locals {
  loaded_policy = jsondecode(file("${path.root}/04-iam/lambda-policy.json"))

  new_statement = {
    "Effect" = "Allow"
    "Action" = [
      "dynamodb:PutItem"
    ]
    "Resource" = var.dynamodb_table_arn
  }

  merged_policy = {
    "Version" = local.loaded_policy.Version
    "Statement" = concat(local.loaded_policy.Statement, [local.new_statement])
  }
}

# create basic role for lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.prefix}-lambda-role"
  assume_role_policy = file("${path.root}/04-iam/lambda-role.json")
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  name = "${var.prefix}-lambda-role-policy"
  role = aws_iam_role.lambda_role.id
  policy = jsonencode(local.merged_policy)
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn 
}

output "policy" {
  value = local.merged_policy
}
output "loaded_policy" {

  value = local.loaded_policy
}
