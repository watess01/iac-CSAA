


resource "aws_internet_gateway" "igw" {
  vpc_id = var.aws_vpc_id
  tags = {
    name = "${var.prefix}-igw"
  }
}

resource aws_route_table public {
  
  vpc_id = var.aws_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "${var.prefix}-Public-RT"
    }
}

resource "aws_main_route_table_association" "main-rt-assoc" {
  vpc_id         =  var.aws_vpc_id
  route_table_id = aws_route_table.public.id
}


resource "aws_security_group" "allow_ssh_http" {
  name        = "${var.prefix}-vpc-sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id = var.aws_vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "${var.prefix}-vpc-sg"
  }
}


