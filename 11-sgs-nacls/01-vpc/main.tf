
# create a vpc with a private and public subnet. The public subnet will permit interet & ssh access
# the private subnet will permit ssh access from the public subnet
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

# create private subnet in the vpc
resource "aws_subnet" "private-subnet" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.prefix}-private-${var.availability_zones[count.index]}"
  }
}

resource "aws_subnet" "public" {
  count = length(var.availability_zones)
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${10+count.index}.0/24"
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.prefix}-public-${var.availability_zones[count.index]}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    name = "${var.prefix}-igw"
  }
}

resource aws_route_table public {
  
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "${var.prefix}-rt-public"
    }
}

# associate the route table with the public subnets
resource "aws_route_table_association" "a" {
  count = length(var.availability_zones)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "${var.prefix}-vpc-sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

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