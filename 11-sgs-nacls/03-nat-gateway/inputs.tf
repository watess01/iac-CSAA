variable "prefix" { default = "trg-11" }
variable "availability_zones" {  default = ["eu-west-1a","eu-west-1b"] }
variable "aws_subnets" { type = list(string) }
variable "private_rt" { type = string }
variable "aws_vpc_id" { type = string }