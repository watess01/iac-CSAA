variable "availability_zone" {  default = "eu-west-1a" }
variable "instance_type" { default = "t2.micro" }
# variable "instance_key" { default = "bastion" }
# variable "creds" { default  = "~/.aws/credentials"}
variable "vpc_cidr" { default = "172.31.0.0/16" }
variable "subnet_cidr" { default = "172.31.0.0/20" }
variable ami { default = "ami-07355fe79b493752d" }
variable prefix { default = "trg13" }
variable "region" {  default = "eu-west-1" }
variable "instance_key" { default = "bastion" }