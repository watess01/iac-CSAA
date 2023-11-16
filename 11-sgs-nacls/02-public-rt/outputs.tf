
output "aws_security_group_id" {
    value = aws_security_group.allow_ssh_http.id
    
    
}
# output "private_rt" {
#   value = aws_route_table.private.id
# }
# output "igw_id" {
#   value = aws_internet_gateway.igw.id
  
# }