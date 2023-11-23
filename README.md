# Project for Hands on Labs for AWS Certified Solutions Architect Associate

## Introduction

While public, this repo is designed for my personal use. It's purpose is to retain the Hands On Labs
for the AWS Associate Architect Certification study. Projects may be incomplete, if the subject matter
doesnt require further investigation. The Projects are for practical understanding of subject matter,
rather than perfect delivery.

## Subjects

1. Key Pair
2. EC2 Instance
3. Bastion Host
4. EC2 Snapshot - Create AMI snapshot
5. Autoscaling
6. VPC
7. Web Server - with ALB & NLB over 2 regions & 2 azs
8. Security Groups & NACLs
9. VPC Peering
10. Containers
11. ECS Fargate Tasks
12. App Runner - NGINX WebServer on Docker on EC2 in an App Runner
13. Simple Serverless - Python Lambda Hello World
14. Simple Event Driven App - SQS -> Lambda -> DynamoDb
15. Step Functions -> StateMachine Workflow, Python Lambda

## terraform

- tutorials: `https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli`
- download terraform on client: `brew tap hashicorp/tap`
- install terraform: `brew install hashicorp/tap/terraform`

### Execute Terraform

- When code changes: `terraform init`
- Review changes: `terraform plan`
- Implement: `terraform apply`
- Drop changes: `terraform destroy`
