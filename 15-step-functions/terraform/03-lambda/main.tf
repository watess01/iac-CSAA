resource "aws_lambda_function" "MyLambda" {
  filename      = "../out/troll.zip"
  function_name = "troll_chase_handler"
  role          = var.lambda_role_arn
  handler       = "troll.troll_chase_handler"
  source_code_hash = filebase64sha256("../out/troll.zip")
  runtime = "python3.8"
  timeout = var.timeout
  memory_size = 128
  publish = true
  tags = {
    Name =  "troll_chase_handler"
  }
  # add trigger for SQS queue
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping
  
}
