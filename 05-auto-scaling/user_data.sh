#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EC2AZ=$(TOKEN-`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/placement/availability-zone)
echo '<center><h1>This AWS EC2 instance in located in availability zone@ AZID </h1></center>' > /var/www/html/index.txt
sed -i "s/AZID/$EC2AZ/" /var/www/html/index.txt > /var/www/html/index.html
