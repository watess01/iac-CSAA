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

resource "aws_instance" "foo" {
  ami           = "ami-0dab0800aa38826f2" # eu-west-1
  instance_type = "t2.micro"

}
