#!/bin/bash
sleep 10

echo "*** Installing httpd"
sudo yum update -y
sudo yum -y install httpd
sudo service httpd start  
echo "*** Completed Installing httpd"
EC2AZ=$(TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/placement/availability-zone)
sudo mkdir -p /var/www/html
sudo echo '<html><body><p>Availability Zone : '$EC2AZ' ...</p></body></html>' >> /var/www/html/index.html
  