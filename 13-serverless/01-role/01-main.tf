
# create basic role for lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.prefix}-lambda-role"
  assume_role_policy = file("${path.root}/01-role/lambda-role.json")
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
  
}