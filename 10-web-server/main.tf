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


module "web-server" {
  source = "./01-web-server"
  vpc_cidr = var.vpc_cidr
  availability_zones = var.availability_zones
  instance_type = var.instance_type
  ami = var.ami
  prefix = var.prefix
}



