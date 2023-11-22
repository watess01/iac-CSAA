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
  prefix = var.prefix
}

module "iam" {
  source = "./02-iam"
  depends_on = [ module.vpc ]
  prefix = var.prefix
}

# create a lambda using the python code in the ./src directory
module "sqs" {
  source = "./03-sqs"
  depends_on = [ module.vpc ]
  prefix = var.prefix
  timeout = var.timeout
}

module "lambda" {
  source = "./04-lambda"
  depends_on = [ module.iam ]
  lambda_role_arn = module.iam.lambda_role_arn
  prefix = var.prefix
  sqs_arn = module.sqs.sqs_arn
  timeout = var.timeout
}

module "db" {
  source = "./05-dynamodb"
  depends_on = [ module.vpc ]
  prefix = var.prefix
}