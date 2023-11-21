resource "aws_instance" "web" {
  ami             = var.ami
  instance_type   = var.instance_type

  subnet_id       = var.aws_subnet_id
  availability_zone = var.availability_zone
  associate_public_ip_address = true
  key_name = var.instance_key
  

  # access userdata script form main folder
  user_data = file("${path.root}/04-ec2/userdata.sh")
  tags = {
    Name = "${var.prefix}-web_instance"
  }
  security_groups = [ var.security_group_id ]
  volume_tags = {
    Name = "${var.prefix}-instance"
  }
  # assign role to instance
  iam_instance_profile = var.ECRProfileName
}

output "ec2_global_ips" {
  value = ["${aws_instance.web.public_ip}"]
}