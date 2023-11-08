
resource aws_route_table public {
  
  vpc_id = var.aws_vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
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


resource "aws_route_table" "private" {
  vpc_id = var.aws_vpc_id
  route {
    cidr_block = "0.0.0.0/0"    
  }
  tags = {
    name = "${var.prefix}-rt-private"
  }
}