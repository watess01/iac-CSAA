
# create vpc
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.prefix}-vpc"
    }
}
# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# public subnet
resource "aws_subnet" "public" {
  count = length(var.availability_zones)
  availability_zone = var.availability_zones[count.index]
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
}

# route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        name = "${var.prefix}-public_rt"
    }
}

# associate route table with subnet
resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

