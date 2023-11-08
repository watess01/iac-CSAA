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

module "rt" {
  source = "./02-rt"
  depends_on = [ module.vpc ]
  prefix = var.prefix
  aws_vpc_id = module.vpc.aws_vpc_id
  availability_zones = var.availability_zones
  aws_subnets = module.vpc.public_subnets
  igw_id = module.vpc.igw_id
}

module "nat-gateway" {
  source = "./03-nat-gateway"
  depends_on = [ module.rt ]
  prefix = var.prefix
  aws_vpc_id = module.vpc.aws_vpc_id
  availability_zones = var.availability_zones
  aws_subnets = module.vpc.private_subnets
  private_rt = module.private-rt.private_rt
}