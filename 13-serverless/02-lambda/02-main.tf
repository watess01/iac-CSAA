resource "aws_lambda_function" "MyLambda" {
  filename      = "./out/hello.zip"
  function_name = "${var.prefix}-hello"
  role          = var.lambda_role_arn
  handler       = "hello.handler"
  source_code_hash = filebase64sha256("./out/hello.zip")
  # source_code_hash = filebase64sha256("${path.root}/02-lambda/out/hello.zip")
  runtime = "python3.8"
  timeout = 60
  memory_size = 128
  publish = true
  tags = {
    Name = "${var.prefix}-MyLambda"
  }
}