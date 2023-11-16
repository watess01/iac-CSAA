# terraform for Docker containers on ECS

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


module "vpc" {
  source = "./01-vpc" 
}


module "task" {
  source = "./02-task"
  
}

module "cluster" {
  source = "./03-cluster"
  depends_on = [ module.task, module.vpc  ]
  task_def_arn = module.task.task_def_arn
  subnet_ids = module.vpc.subnet_ids
  security_group_id = module.vpc.security_group_id
}