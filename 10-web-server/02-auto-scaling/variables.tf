variable "ami" {
  type = string
}

variable "aws_instance_type" {
  type = string
}

variable "aws_security_group_ids" {
  # type is a list of strings
  type = list(string)
}

variable "aws_key_name" {
  type = string
}

variable "aws_volume_size" {
  type = number
}
variable "aws_volume_type" {
  type = string  
}
variable "availability_zones" {
  type = list(string)
  
}

variable "aws_subnet_public" {
  type = list(object({
    id = string
  }))
}