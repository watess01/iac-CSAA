
# ALB mapped to 2 availability zones, webaccess security group, and 2 target groups
resource "aws_lb" "ALB1" {
    internal = false
    ip_address_type = "ipv4"
  load_balancer_type = "application"
  enable_deletion_protection = false
  security_groups = var.aws_security_group_ids
  subnets            = [for subnet in var.aws_subnet_public : subnet.id]
  name = "ALB1"
  # map to the availability zones
  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "ALB1" {
  load_balancer_arn = aws_lb.ALB1.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.aws_lb_target_group_alb_arn
  }
}