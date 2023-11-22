# HCL to define a dynamoDb
#	Name: ProductVisits
#	Partition key: ProductVisitKey

resource "aws_dynamodb_table" "dynamodb_table" {
  name           = "${var.prefix}-dynamodb_table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "HelloKey"
  attribute {
    name = "HelloKey"
    type = "S"
  }
  tags = {
    Name = "${var.prefix}-dynamodb_table"
  }
}
