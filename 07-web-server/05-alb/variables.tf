variable "aws_lb_target_group_alb_arn" {
  type = string
}

variable "aws_subnet_public" {
  type = list(object({
    id = string
  }))
}

variable "aws_security_group_ids" {
  # type is a list of strings
  type = list(string)
  
}