variable "prefix" { type=string }
variable "availability_zones" {  type=list(string) }
variable "private_subnets" { type = list(string) } 
variable "aws_security_group_id" { type = string}
variable "aws_vpc_id" { type = string }