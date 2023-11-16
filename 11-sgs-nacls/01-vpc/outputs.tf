output "public_subnets" {
  value = aws_subnet.public[*].id
  
}
output "private_subnets" {
  value = aws_subnet.private[*].id
  
}

output "aws_vpc_id" {
  value = aws_vpc.my-vpc.id
  
}
