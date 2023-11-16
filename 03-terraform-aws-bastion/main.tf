# terraform for a bastion host and a private instance
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

# create a vpc
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
    enable_dns_support = true
  enable_dns_hostnames = true
}

# create a public subnet with cidr block 10.0.0.0/16
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
}

# create a private subnet with cidr block 10.0.1.0/24
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

# internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# public route table
resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.main.id  
  # route to internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Associate public subnet with public route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt-public.id
}

# security group for public instance
resource "aws_security_group" "public" {
  name        = "public"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

  # ingress for ssh
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# security group for private instance
resource "aws_security_group" "private" {
  name        = "private"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

  # ingress for ssh
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.public.id]
  }
}


# # create a key pair for the bastion host
resource "tls_private_key" "pk-bastion" {
  algorithm = "RSA"
  
}

# association the key pair with the bastion host
resource "aws_key_pair" "kp-bastion" {
  key_name   = "bastion"
  public_key = tls_private_key.pk-bastion.public_key_openssh
}

# bastion host
# Public EC2 in public subnet
resource "aws_instance" "public" {
  ami           = "ami-0dab0800aa38826f2" # eu-west-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public.id]
  tags = {
    Name = "public-ec2"
  }
  # associate the key pair with the bastion host
  key_name = aws_key_pair.kp-bastion.key_name
}

# export the key pair for the bastion host
output "bastion_key_pair" {
  value = aws_key_pair.kp-bastion.key_name
}
output "bastion_key_pem" {
  value = tls_private_key.pk-bastion.private_key_pem
    sensitive = true

}

# key pair for private instance
# resource "tls_private_key" "pk-private" {
#   algorithm = "RSA"
# }

# resource "aws_key_pair" "kp-private" {
#   key_name   = "private"
#   public_key = tls_private_key.pk-private.public_key_openssh
# }

# private EC2 in private subnet
resource "aws_instance" "private" {
  ami           = "ami-0dab0800aa38826f2" # eu-west-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private.id]
  tags = {
    Name = "private-ec2"
  }
  # associate the key pair with the private instance
  # key_name = aws_key_pair.kp-private.key_name
  
}




# create a key pair for the private instance
resource "tls_private_key" "private" {
  algorithm = "RSA"
}