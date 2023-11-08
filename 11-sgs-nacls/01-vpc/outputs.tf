output "public_subnets" {
  value = aws_subnet.public[*].id
  
}

output "aws_vpc_id" {
  value = aws_vpc.my-vpc.id
  
}
output "igw_id" {
  value = aws_internet_gateway.igw.id
  
}