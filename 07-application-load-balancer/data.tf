# Fetching all availability zones in eu-west-1
data "aws_availability_zones" "azs" {}

data "aws_iam_role" "iam_role" {
   name = "EC2SSMRole"
}