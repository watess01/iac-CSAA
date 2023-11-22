# AWS App Runner with Terraform

## Lesson

https://digitalcloud.training/courses/aws-certified-solutions-architect-associate-hands-on-labs/sections/section-11-serverless-applications-1hr-30m/lessons/aws-lambda/

This creates:

- a lambda named `trg13-hello`

## Build

### boto3

AWS boto3 required to reaccess SQS & DynamoDb
`pip install boto3`

From the command line, run `npm run build13`

This will wrap the python into a zip, then deploy the zip to a lambda named `trg13-hello`

# Deliverable

Execution of the lambda will return "hello world"
