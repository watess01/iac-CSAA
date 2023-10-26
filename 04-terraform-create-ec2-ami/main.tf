# terraform for a repeatable compute layer
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}



# provider for aws and region
provider "aws" {
  region = "eu-west-1"
}



variable "availability_zone" {
  default = "eu-west-1a"
}
# create a vpc
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
    enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "04-terraform-repeatable-compute-layer"
  }
}

# create a public subnet with cidr block 10.0.0.0/16
resource "aws_subnet" "public" {
      availability_zone = var.availability_zone
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
    tags = {
        Name = "04-terraform-repeatable-compute-layer"
    }
}

# security group
resource "aws_security_group" "public" {
  name_prefix = "public-sg-"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance 
resource "aws_instance" "web" {
  ami           = "ami-0dab0800aa38826f2"
    availability_zone = var.availability_zone
    instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public.id]
#   key_name = "terraform"
  tags = {
    Name = "04-terraform-repeatable-compute-layer"
  }
}
# create EBS volume
resource "aws_ebs_volume" "ebs" {
  availability_zone =  var.availability_zone
  size              = 1
  type              = "gp2"
  tags = {
    Name = "04-terraform-repeatable-compute-layer"
  }
}

# attach EBS volume
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = aws_instance.web.id
}

# output "bastion_key_pem" {
#   value = tls_private_key.pk-bastion.private_key_pem
#     sensitive = true
# }

# create an Amazon Machine Image based on the instance
resource "aws_ami_from_instance" "web" {
  name                = "web-ami"
  source_instance_id  = aws_instance.web.id
  # create an EBS snapshot
  snapshot_without_reboot = true
}
# create a launch template based on the custom AMI
resource "aws_launch_template" "web" {
  name = "web-launch-template"
  image_id = format("am%s", aws_ami_from_instance.web.source_instance_id)
  instance_type = "t2.micro"
  # key_name = "terraform"
  vpc_security_group_ids = [aws_security_group.public.id]
  # create an EBS volume
  block_device_mappings {
    device_name = "/dev/sdh"
    ebs {
      volume_size = 1
      volume_type = "gp2"
      delete_on_termination = true
    }
  }
}