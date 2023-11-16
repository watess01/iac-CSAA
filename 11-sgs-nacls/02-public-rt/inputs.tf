variable "prefix" { default = "trg-11" }
variable "availability_zones" {  default = ["eu-west-1a","eu-west-1b"] }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "aws_vpc_id" { type = string }
# variable "igw_id" { type = string }