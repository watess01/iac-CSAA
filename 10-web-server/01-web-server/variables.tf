variable "availability_zones" {  default = ["eu-west-1a","eu-west-1b"] }
variable "instance_type" { default = "t2.micro" }
variable "instance_key" { default = "bastion" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable ami { default = "ami-0dab0800aa38826f2" }
variable prefix { default = "trg" }
