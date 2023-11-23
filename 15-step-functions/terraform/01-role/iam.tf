
# create basic role for lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.prefix}-lambda-role"
  assume_role_policy = file("${path.root}/01-role/lambda-role.json")
}
# role for state machine
resource "aws_iam_role" "sfn_role" {
  name = "${var.prefix}-sfn-role"
  assume_role_policy = file("${path.root}/01-role/sfn-role.json")
}

resource "aws_iam_policy" "sfn_policy" {
  name = "${var.prefix}-sfn-policy"
  policy =  file("${path.root}/01-role/sfn-policy.json")
}

# attach policy to role
resource "aws_iam_role_policy_attachment" "sfn_policy_attachment" {
  role       = aws_iam_role.sfn_role.name
  policy_arn = aws_iam_policy.sfn_policy.arn
}

output "sfn_role_arn" {
  value = aws_iam_role.sfn_role.arn 
}

output "sfn_policy_name" {
  value = aws_iam_policy.sfn_policy.name 
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn 
}