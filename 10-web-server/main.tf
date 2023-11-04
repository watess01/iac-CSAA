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

module "tg" {
  
  depends_on = [module.web-server]
  source = "./02-tg"
  availability_zones = var.availability_zones
  vpc_id = module.web-server.vpc_id
  aws_instance_web = module.web-server.aws_instance_web

}

module "nlb" {
  depends_on = [ module.tg ]
  source = "./03-nlb"
  aws_lb_target_group_nlb_arn = module.tg.aws_lb_target_group_nlb_arn
  aws_subnet_public = module.web-server.aws_subnet_public
}

module "alb" {
  depends_on = [ module.tg ]
  source = "./04-alb"
  aws_lb_target_group_alb_arn = module.tg.aws_lb_target_group_alb_arn
  aws_subnet_public = module.web-server.aws_subnet_public
  aws_security_group_ids = module.web-server.aws_security_group_ids
  
}