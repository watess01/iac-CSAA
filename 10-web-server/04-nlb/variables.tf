variable "aws_lb_target_group_nlb_arn" {
  type = string
}

variable "aws_subnet_public" {
  type = list(object({
    id = string
  }))
}