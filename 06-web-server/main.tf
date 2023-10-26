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

# create vpc
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
    tags = {
        Name = "06-my_vpc"
    }
}
# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# public subnet
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr
}

# route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        name = "06-public_rt"
    }
}

# associate route table with subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_instance" "web" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.instance_key
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing httpd"
  sudo yum update -y
  sudo yum -y install httpd
  sudo service httpd start  
  echo "*** Completed Installing httpd"
  sudo mkdir -p /var/www/html
  sudo echo '<html><body><p>Hello World</p></body></html>' >> /var/www/html/index.html
  EOF

  tags = {
    Name = "06-web_instance"
  }

  volume_tags = {
    Name = "06-web_instance"
  } 
}

output "ec2_global_ips" {
  value = ["${aws_instance.main.*.public_ip}"]
}