

# create Network Load Balancer a
resource "aws_lb" "NLB1" {
    internal = false
    ip_address_type = "ipv4"
  load_balancer_type = "network"
  enable_deletion_protection = false
  subnets            = [for subnet in aws_subnet.public : subnet.id]
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

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb.arn
  }
}
# ALB mapped to 2 availability zones, webaccess security group, and 2 target groups
resource "aws_lb" "ALB1" {
    internal = false
    ip_address_type = "ipv4"
  load_balancer_type = "application"
  enable_deletion_protection = false
  security_groups = [aws_security_group.webaccess.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]
  # map to the availability zones
  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "ALB1" {
  load_balancer_arn = aws_lb.ALB1.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }
}