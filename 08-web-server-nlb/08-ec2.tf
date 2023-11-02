# terraform for a repeatable compute layer
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}



# provider for aws and region
provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "web" {
  # 1 instance per availability zone
  count             = length(var.availability_zones)
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.instance_key
  subnet_id       = aws_subnet.public[count.index].id
  security_groups = [aws_security_group.sg.id]
  availability_zone = var.availability_zones[count.index]
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing httpd"
  sudo yum update -y
  sudo yum -y install httpd
  sudo service httpd start  
  echo "*** Completed Installing httpd"
  sudo mkdir -p /var/www/html
  sudo echo '<html><body><p>Hello World</p></body></html>' >> /var/www/html/index.html
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