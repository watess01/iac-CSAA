terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "foo" {
  ami           = "ami-0dab0800aa38826f2" # eu-west-1
  instance_type = "t2.micro"

}


# create a vpc with a private and public subnet. The public subnet will permit interet & ssh access
# the private subnet will permit ssh access from the public subnet
resource "vpc" "my-vpc" {
  name = "my-vpc"
  cidr_block = "10.0.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "my-vpc"
  }
  region = aws.region
}

# create private subnet in the vpc
resource "aws_subnet" "private-subnet" {
  count = length(var.availability_zones)
  vpc_id = vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
}

# create public subnet in the vpc
resource "aws_subnet" "public-subnet" {
  vpc_id = vpc.my-vpc.id
  cidr_block = "10.0.2.0/31"
  # internet gateway


}

# route table for public subnet with ssh & http access
resource "aws_route_table" "public-route-table" {
  vpc_id = vpc.my-vpc.id
}
resource "aws_internet_gateway" "igw" {
  vpc_id = vpc.my-vpc.id
}
