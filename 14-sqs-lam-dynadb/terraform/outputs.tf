
output "sqs-command" {
    value = "aws sqs send-message --queue-url ${module.sqs.sqs_url} --message-body 'Hello World'"
}

