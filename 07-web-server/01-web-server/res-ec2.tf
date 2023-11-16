resource "aws_instance" "web" {
  # 1 instance per availability zone
  count           = length(var.availability_zones)
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.instance_key
  subnet_id       = aws_subnet.public[count.index].id
  security_groups = [aws_security_group.webaccess.id]
  availability_zone = var.availability_zones[count.index]
  associate_public_ip_address = true

  # access userdata script form main folder
  user_data = filebase64("${path.root}/userdata.sh")
  tags = {
    Name = "${var.prefix}-web_instance"
  }

  volume_tags = {
    Name = "${var.prefix}-nstance"
  } 
}

output "ec2_global_ips" {
  value = ["${aws_instance.web.*.public_ip}"]
}