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


module "vpc" {
  source = "./01-vpc"
  prefix = var.prefix
  availability_zones = var.availability_zones

  
}

module "public-rt" {
  source = "./02-public-rt"
  depends_on = [ module.vpc ]
  prefix = var.prefix
  aws_vpc_id = module.vpc.aws_vpc_id
  availability_zones = var.availability_zones
  public_subnets = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
}

module "private-rt" {
  source = "./03-private-rt"
  depends_on = [ module.public-rt ]
  prefix = var.prefix
  aws_vpc_id = module.vpc.aws_vpc_id
  availability_zones = var.availability_zones
  aws_subnets = module.vpc.private_subnets

}

module "ec2" {
  source = "./04-ec2"
  depends_on = [ module.private-rt ]
  prefix = var.prefix
  aws_vpc_id = module.vpc.aws_vpc_id
  availability_zones = var.availability_zones
  aws_subnets = module.vpc.private_subnets
  public_subnets = module.vpc.public_subnets
  aws_security_group_id = module.public-rt.aws_security_group_id
}