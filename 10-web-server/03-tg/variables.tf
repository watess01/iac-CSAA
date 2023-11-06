variable "availability_zones" {  default = ["eu-west-1a","eu-west-1b"] }
variable prefix { default = "trg" }

variable "vpc_id" {
    type = string
}

variable "aws_instance_web" {
    type = list(object({
        id = string
        public_ip = string
    }))
}