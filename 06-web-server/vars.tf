variable "availability_zone" {  default = "eu-west-1a" }
variable "instance_type" { default = "t2.micro" }
variable "instance_key" { default = "bastion" }
# variable "creds" { default  = "~/.aws/credentials"}
variable "vpc_cidr" { default = "178.0.0.0/16" }
variable "public_subnet_cidr" { default = "178.0.10.0/24" }
variable ami { default = "ami-0dab0800aa38826f2" }
