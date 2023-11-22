# HCL to define an SQS queue
resource "aws_sqs_queue" "sqs_queue" {
  name                      = "${var.prefix}-sqs_queue"
  delay_seconds             = 1
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 1
  visibility_timeout_seconds = var.timeout
  tags = {
    Name = "${var.prefix}-sqs_queue"
  }
}

output "sqs_arn" {
  value = aws_sqs_queue.sqs_queue.arn
}
