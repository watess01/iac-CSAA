variable "prefix" {
    type = string
}
variable "lambda_role_arn" {
    type = string
}
variable "sqs_arn" {
    type = string
}
variable "timeout" { type = number }