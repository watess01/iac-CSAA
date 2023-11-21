#!/bin/bash

sleep 10

sudo su

yum update -y
yum install -y  docker
systemctl enable docker.service
systemctl start docker.service
docker pull nginx
docker images


# yum install -y ec2-instance-connect

echo 'SW: create repository...'
aws ecr create-repository --repository-name nginx --region eu-west-1

echo 'SW: tag nginx...'
docker tag nginx:latest 859079231122.dkr.ecr.eu-west-1.amazonaws.com/nginx:latest

echo 'SW: docker login...'
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 859079231122.dkr.ecr.eu-west-1.amazonaws.com/nginx

echo 'SW: docker push...'
docker push 859079231122.dkr.ecr.eu-west-1.amazonaws.com/nginx:latest

echo 'SW: Done!'
