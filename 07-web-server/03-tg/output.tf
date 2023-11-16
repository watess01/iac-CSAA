# output "web_instance_ip" {
#     value = aws_instance.web.*.public_ip
# }
output "aws_lb_target_group_nlb_arn" {
  value = aws_lb_target_group.nlb.arn
}
output "aws_lb_target_group_alb_arn" {
  value = aws_lb_target_group.alb.arn
}

