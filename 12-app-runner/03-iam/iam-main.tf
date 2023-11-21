# create iam policy
resource "aws_iam_policy" "ECRPolicy" {
  name        = "ECRPolicy"
  description = "ECRPolicy"
  policy      = file("${path.root}/03-iam/ecr-policy.json")

}


# create ECRRole that ises ECRPolicy
resource "aws_iam_role" "ECRRole" {
  name               = "ECRRole"
  assume_role_policy = file("${path.root}/03-iam/ecr-trust.json")
}

resource "aws_iam_instance_profile" "ECRInstanceProfile" {
  name = "ECRInstanceProfile"
  role = aws_iam_role.ECRRole.name
}

resource "aws_iam_role_policy_attachment" "ECRRolePolicyAttach" {
  role       = aws_iam_role.ECRRole.name
  policy_arn = aws_iam_policy.ECRPolicy.arn
}


output "ECRProfileName" {
  value = aws_iam_instance_profile.ECRInstanceProfile.name
}