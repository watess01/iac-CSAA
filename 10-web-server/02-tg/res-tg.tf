# Create traget group one for each instance

resource "aws_lb_target_group" "alb" {

    target_type = "instance"
    name = "${var.prefix}-ALB"
    protocol    = "HTTP"
    port        = 80
    vpc_id      = var.vpc_id 
    
    health_check {
        path = "/"
        port = 80
        healthy_threshold = 5
        unhealthy_threshold = 2
        timeout = 5
        interval = 30
        # success codes
        matcher = "200,202"         
    }
}

# attach instances to target group

resource "aws_lb_target_group_attachment" "alb" {
    count = length(var.availability_zones)
    target_group_arn = aws_lb_target_group.alb.arn
    target_id = var.aws_instance_web[count.index].id
    port = 80
}

# create 2nd Target group for the NLB
resource "aws_lb_target_group" "nlb" {

    target_type = "instance"
    name = "TG-NLB"
    protocol    = "TCP"
    port        = 80
    vpc_id      = var.vpc_id

    health_check {
        port = 80
        protocol = "TCP"
        healthy_threshold = 5
        unhealthy_threshold = 2
        timeout = 5
        interval = 30
    }
}

resource "aws_lb_target_group_attachment" "nlb" {
    count = length(var.availability_zones)
    target_group_arn = aws_lb_target_group.nlb.arn
    target_id = var.aws_instance_web[count.index].id
    port = 80
}

