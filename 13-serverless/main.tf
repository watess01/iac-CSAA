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

module "iam" {
  source = "./01-role"
  prefix = var.prefix
}

# create a lambda using the python code in the ./src directory
module "lambda" {
  source = "./02-lambda"
  depends_on = [ module.iam ]
  lambda_role_arn = module.iam.lambda_role_arn
  prefix = var.prefix
}