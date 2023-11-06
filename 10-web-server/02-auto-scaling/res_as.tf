# create launch template
resource "aws_launch_template" "ASG" {
  # name_prefix = "ASG"
  name = "MyLT"
  image_id = var.ami

  instance_type = var.aws_instance_type
  key_name = var.aws_key_name
  
  vpc_security_group_ids = [for id in var.aws_security_group_ids : id]
 
  user_data = filebase64("${path.root}/userdata.sh")
  # map to the availability zones
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.aws_volume_size
      volume_type = var.aws_volume_type
      delete_on_termination = true
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ASG"
    }
  }
  
}

# create auto scaling group
resource "aws_autoscaling_group" "ASG1" {
  launch_template {
    id = aws_launch_template.ASG.id
    version = "$Latest"
  }
  name = "ASG1"
  # availability_zones = var.availability_zones
  desired_capacity = 2
  max_size = 2
  min_size = 2
  vpc_zone_identifier = [for subnet in var.aws_subnet_public : subnet.id]
  
}
