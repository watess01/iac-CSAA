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

module "db" {
  source = "./02-dynamodb"
  # depends_on = [ module.vpc ]
  prefix = var.prefix
}

module "sqs" {
  source = "./03-sqs"
  # depends_on = [ module.vpc ]
  prefix = var.prefix
  timeout = var.timeout
}
module "iam" {
  source = "./04-iam"
  depends_on = [  module.db, module.sqs ]
  prefix = var.prefix
  dynamodb_table_arn = module.db.dynamodb_table_arn
}

module "lambda" {
  source = "./05-lambda"
  depends_on = [ module.iam, module.sqs ]
  lambda_role_arn = module.iam.lambda_role_arn
  prefix = var.prefix
  sqs_arn = module.sqs.sqs_arn
  timeout = var.timeout
}


output "policy" {
  value = module.iam.policy
}

output "loaded_policy" {
  value = module.iam.loaded_policy
}