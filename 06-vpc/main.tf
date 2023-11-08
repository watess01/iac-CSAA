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
}

module "security_group" {
  source = "./02-security-group"
  depends_on = [ module.vpc ]
  vpc_id = module.vpc.vpc_id
  prefix = var.prefix
}
 