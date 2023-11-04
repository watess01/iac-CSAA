

# create Network Load Balancer a
resource "aws_lb" "NLB1" {
    internal = false
    ip_address_type = "ipv4"
  load_balancer_type = "network"
  enable_deletion_protection = false
  subnets            = [for subnet in var.aws_subnet_public : subnet.id]
  # map to the availability zones



  tags = {
    Environment = "production"
  }

}

# add listener to NLB
resource "aws_lb_listener" "NLB1" {
  load_balancer_arn = aws_lb.NLB1.arn
  port              = "80"
  protocol          = "TCP"
  tags = {
    name = "NLB1"
  }

  default_action {
    type             = "forward"
    target_group_arn = var.aws_lb_target_group_nlb_arn
  }
}
