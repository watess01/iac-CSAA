
# create basic role for lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.prefix}-lambda-role"
  assume_role_policy = file("${path.root}/02-iam/lambda-role.json")
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  name = "${var.prefix}-lambda-role-policy"
  role = aws_iam_role.lambda_role.id
  policy = file("${path.root}/02-iam/lambda-policy.json")
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn 
}