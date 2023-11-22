resource "aws_lambda_function" "MyLambda" {
  filename      = "../out/hello.zip"
  function_name = "${var.prefix}-hello"
  role          = var.lambda_role_arn
  handler       = "hello.handler"
  source_code_hash = filebase64sha256("../out/hello.zip")
  runtime = "python3.8"
  timeout = 60
  memory_size = 128
  publish = true
  tags = {
    Name = "${var.prefix}-MyLambda"
  }
  # add trigger for SQS queue
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping
  
}

resource "aws_lambda_event_source_mapping" "sqs_mapping" {
  event_source_arn = var.sqs_arn
  function_name    = aws_lambda_function.MyLambda.arn
  enabled = true
  batch_size = 1
}