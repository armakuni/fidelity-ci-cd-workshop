locals {
  concourse_hostanme_prefix = "fil-workshop-cci"
  concourse_hostname        = "${local.concourse_hostanme_prefix}.${data.aws_route53_zone.ak_training.name}"
}

resource "aws_iam_instance_profile" "concourse_profile" {
  name = "${var.prefix}-concourse-ec2"
  role = aws_iam_role.concourse.id
}

resource "aws_iam_role_policy_attachment" "admin_access" {
  role       = aws_iam_role.concourse.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}