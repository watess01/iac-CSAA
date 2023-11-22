# AWS App Runner with Terraform

## Lesson

https://digitalcloud.training/courses/aws-certified-solutions-architect-associate-hands-on-labs/sections/section-11-serverless-applications-1hr-30m/lessons/aws-lambda/

This creates:

- a lambda named `trg13-hello`

## Build

Build can be done in steps, or with a single command

1. build the python zip
2. build the infrastructure & deploy the zip

### Stage 1 - Build the python zip

This packages the python code into a zip file, where it may be deployed to AWS

`npm run zip14`

### Build Infrastructure

This runs the Terraform HCL and builds the infrastructure on AWS, and deploys the Zip file to the lambda

`npm run hcl14`

This can also be executed by using the Teraform commands from the `terraform` folder.

`terraform init` - prepare the folder structure
`terraform plan` - check changes
`terraform apply` - build the infrastructure

There is an error that indicates the source mapping is already created. The source mapping attaches the lambda to the SQS queue. This can be resolved with the `refresh` option:

`terraform refresh`

### boto3

AWS boto3 required to reaccess SQS & DynamoDb
`pip install boto3`

From the command line, run `npm run build13`

This will wrap the python into a zip, then deploy the zip to a lambda named `trg13-hello`

# Deliverable

Send a message to the SQS queue:

1. log written to cloudwatch
2. the message written to dynamodb

# Note

1. At time of writing, there is an error that indicates the source mapping is already created. The source mapping attaches the lambda to the SQS queue. This can be resolved with the `refresh` option:

`terraform refresh`

2. At time of writing, this does not execute first time. For some reason, the message gets stuck in SQS. The Solution is to edit the lambda trigger. Once saved, the messages will be received.
