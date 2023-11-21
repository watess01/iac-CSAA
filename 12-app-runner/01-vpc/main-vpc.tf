resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true  
  tags = {
    Name = "my-vpc"
  }
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  availability_zone = var.availability_zone
  cidr_block              = var.subnet_cidr
  }

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id  
  # route to internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public.id
}
