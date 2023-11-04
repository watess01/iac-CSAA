output "web_instance_ip" {
    value = aws_instance.web.*.public_ip
}
output "vpc_id" {
    value = aws_vpc.my_vpc.id
}

output "aws_instance_web" {
    value = aws_instance.web
}


output "aws_subnet_public" {
    value = aws_subnet.public
}

output "aws_security_group_ids" {
    value = [aws_security_group.webaccess.id]
}