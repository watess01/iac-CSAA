# Project for Hands on Labs for AWS Certified Solutions Architect Associate

## Introduction

While public, this repo is designed for my personal use. It's purpose is to retain the Hands On Labs
for the AWS Associate Architect Certification study. Projects may be incomplete, if the subject matter
doesnt require further investigation. The Projects are for practical understanding of subject matter,
rather than perfect delivery.

## Subjects

0. Key Pair
1. EC2 Instance
2. Bastion Host
3. EC2 Snapshot - Create AMI snapshot
4. Autoscaling
5. VPC
6. Web Server - with ALB & NLB over 2 regions & 2 azs
7. Security Groups & NACLs
8. VPC Peering
9. Containers
10. ECS Fargate Tasks
11. App Runner - NGINX WebServer on Docker on EC2 in an App Runner
12. Simple Serverless - Python Lambda Hello World
13. Simple Event Driven App - SQS -> Lambda -> DynamoDb

## terraform

- tutorials: `https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli`
- download terraform on client: `brew tap hashicorp/tap`
- install terraform: `brew install hashicorp/tap/terraform`

### Execute Terraform

- When code changes: `terraform init`
- Review changes: `terraform plan`
- Implement: `terraform apply`
- Drop changes: `terraform destroy`
