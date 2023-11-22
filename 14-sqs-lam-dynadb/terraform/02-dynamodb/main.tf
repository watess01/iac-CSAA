# HCL to define a dynamoDb
#	Name: ProductVisits
#	Partition key: ProductVisitKey

resource "aws_dynamodb_table" "dynamodb_table" {
  name           = "${var.prefix}-dynamodb_table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "${var.prefix}-dynamodb_table"
  }
}
output "dynamodb_table_arn" {
  value = aws_dynamodb_table.dynamodb_table.arn
}

