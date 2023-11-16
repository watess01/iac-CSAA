# create an ec2 webserver in the public subnet
resource "aws_instance" "webserver" {
    count = length(var.availability_zones)
  ami           = "ami-0dab0800aa38826f2" # eu-west-1
  instance_type = "t2.micro"
  subnet_id     = var.public_subnets[count.index]
  vpc_security_group_ids = [var.aws_security_group_id]
  tags = {
    Name = "webserver${count.index}"
  }
  associate_public_ip_address = true
  user_data = file("${path.module}/userdata.sh")
  # associate the key pair with the bastion host
  key_name = "bastion"
}