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

  # web access security group
resource "aws_security_group" "example" {
    name_prefix = "example-"
    description = "Allow web traffic"
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

# # create launch template based on "ami-0dab0800aa38826f2" (eu-west-1) t2-micro
resource "aws_launch_template" "example" {
    name_prefix = "example-"
    image_id = "ami-0dab0800aa38826f2"
    instance_type = "t2.micro"
    security_group_names = [aws_security_group.example.name]
    # user_data = data.template_file.user_data.rendered
  key_name = aws_key_pair.kp-bastion.key_name
  
  
}

# # advanced details

# # user data text    
data "template_file" "user_data" {
  template = file("user_data.sh")
}

output "bastion_key_pem" {
  value = tls_private_key.pk-bastion.private_key_pem
    sensitive = true
}
resource "tls_private_key" "pk-bastion" {
  algorithm = "RSA"
  
}

resource "aws_key_pair" "kp-bastion" {
  key_name   = "bastion"
  public_key = tls_private_key.pk-bastion.public_key_openssh
}

resource "aws_instance" "ex-05-autoscaling" {
  ami           = "ami-0dab0800aa38826f2" # eu-west-1
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.example.name]
  tags = {
    Name = "05-ec2"
  }
  # associate the key pair with the private instance
  key_name = aws_key_pair.kp-bastion.key_name
    # set number of instances
    count = 2
}
