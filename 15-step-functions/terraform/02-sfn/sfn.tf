resource "aws_sfn_state_machine" "sfn_state_machine" {
    name     = "${var.prefix}-sfn-state-machine"
    role_arn = var.sfn_role_arn

    definition = file("${path.root}/02-sfn/sfn.json")
}

