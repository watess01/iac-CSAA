variable "availability_zones" {  default = ["eu-west-1a","eu-west-1b"] }
# variable "instance_count" { default = "2" }
variable "instance_type" { default = "t2.micro" }
variable "instance_key" { default = "bastion" }
# variable "creds" { default  = "~/.aws/credentials"}
variable "vpc_cidr" { default = "10.0.0.0/16" }
# variable "public_subnet_cidr" { default = "10.0.1.0/25" }
variable prefix { default = "trg" }
