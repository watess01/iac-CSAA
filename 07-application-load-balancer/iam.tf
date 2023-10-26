# iam role for EC2 instances

# resource "aws_iam_role" "iam_role" {
#   name = "EC2SSMRole"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         # attach AmazonSSMManagedInstanceCore policy
#       },
#     ]
#   })

#   tags = {
#     tag-key = "tag-value"
#   }
# }
# # attach aws_iamrole.iam_role to AmazonSSMManagedInstanceCore policy
# resource "aws_iam_role_policy_attachment" "name" {
#   role       = data.aws_iam_role.iam_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }

