resource "aws_instance" "web" {
  # 1 instance per availability zone
  count           = length(var.availability_zones)
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.instance_key
  subnet_id       = aws_subnet.public[count.index].id
  security_groups = [aws_security_group.webaccess.id]
  availability_zone = var.availability_zones[count.index]
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing httpd"
  sudo yum update -y
  sudo yum -y install httpd
  sudo service httpd start  
  echo "*** Completed Installing httpd"
  EC2AZ=$(TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/placement/availability-zone)
  sudo mkdir -p /var/www/html
  sudo echo '<html><body><p>Availability Zone : '$EC2AZ' ...</p></body></html>' >> /var/www/html/index.html
  EOF

  tags = {
    Name = "${var.prefix}-web_instance"
  }

  volume_tags = {
    Name = "${var.prefix}-nstance"
  } 
}

output "ec2_global_ips" {
  value = ["${aws_instance.web.*.public_ip}"]
}