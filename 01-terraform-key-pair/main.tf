# terraform for a bastion host and a private instance
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
# provider for aws and region.
provider "aws" {
  region = "eu-west-1"
}

# create a key pair for the bastion host
resource "tls_private_key" "pk-bastion" {
  algorithm = "RSA"
  
}
resource "aws_key_pair" "kp-bastion" {
  key_name   = "bastion"
  public_key = tls_private_key.pk-bastion.public_key_openssh
}



output "bastion_key_pair" {
  value = aws_key_pair.kp-bastion.key_name
}
output "bastion_key_pem" {
  value = tls_private_key.pk-bastion.private_key_pem
    sensitive = true

}
