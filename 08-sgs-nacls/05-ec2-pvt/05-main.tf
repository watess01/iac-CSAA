# create an ec2 webserver in the public subnet
resource "aws_instance" "private-server" {
    count = length(var.availability_zones)
  ami           = "ami-0dab0800aa38826f2" # eu-west-1
  instance_type = "t2.micro"
  subnet_id     = var.private_subnets[count.index]
  vpc_security_group_ids = [var.aws_security_group_id,aws_security_group.private-sg.id]
  tags = {
    Name = "be-server-${count.index}"
  }
  associate_public_ip_address = false
  # associate the instance with security group

}

resource "aws_security_group" "private-sg" {
  name        = "${var.prefix}-vpc-sg-pvt"
  description = "Allow bastion to private ec2 communication"
  vpc_id = var.aws_vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }
  # allow ping
  ingress {
    description = "ICMP from anywhere"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    name = "${var.prefix}-vpc-sg-pvt"
  }
}
