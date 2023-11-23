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

module "role" {
    source = "./01-role"
    prefix = var.prefix
}

module "sfn" {
    source = "./02-sfn"
    depends_on = [ module.role ]
    prefix = var.prefix
    sfn_role_arn = module.role.sfn_role_arn
}
module "lambda" {
    source = "./03-lambda"
    depends_on = [ module.role ]
    prefix = var.prefix
    lambda_role_arn = module.role.lambda_role_arn
    timeout = var.timeout
  
}
