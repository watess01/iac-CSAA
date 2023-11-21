# terraform to create a vpc
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
    region = var.region
}

module "vpc" {
  source = "./01-vpc"
  vpc_cidr = var.vpc_cidr  
  subnet_cidr = var.subnet_cidr
  availability_zone = var.availability_zone
}

module "security_group" {
  source = "./02-security-group"
  depends_on = [ module.vpc ]
  vpc_id = module.vpc.vpc_id
  prefix = var.prefix
}
 
module "iam" {
  source = "./03-iam"
  depends_on = [ module.security_group ]
}


module "ec2" {
  source = "./04-ec2"
  depends_on = [ module.iam ]
  security_group_id = module.security_group.security_group_id
  instance_type = var.instance_type
  ami = var.ami
  aws_subnet_id = module.vpc.subnet_id
  vpc_cidr = var.vpc_cidr  
  prefix = var.prefix
  availability_zone = var.availability_zone
  instance_key = var.instance_key
  ECRProfileName = module.iam.ECRProfileName
}

module "ecr" {
  source = "./05-app-runner"
  depends_on = [ module.ec2, module.iam ]
  prefix = var.prefix
  ECRPRoleArn = module.iam.ECRPRoleArn
}
