
# assign elastic ip
resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "${var.prefix}-nat"
  }
}

# create nat gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = var.aws_subnets[0]
  connectivity_type = "public"
  tags = {
    Name = "${var.prefix}-nat"
  }
}

# create association of private route table with private subnet
resource "aws_route_table_association" "private" {
  count = length(var.aws_subnets)
  subnet_id = var.aws_subnets[count.index]
  route_table_id = aws_route_table.private.id
}

# create route association for private route table with nat gateway
resource "aws_route" "private" {
  count = length(var.aws_subnets)
  route_table_id = aws_route_table.private.id
  nat_gateway_id = aws_nat_gateway.nat.id
  destination_cidr_block = "0.0.0.0/0"
}