locals {
  concourse_hostanme_prefix = "concourse"
  concourse_hostname        = "${local.concourse_hostanme_prefix}.${data.aws_route53_zone.ak_training.name}"
}
# VPC
resource "aws_vpc" "cci" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "cci-workshop"
  }
}

# Subnet
resource "aws_subnet" "cci" {
  vpc_id     = aws_vpc.cci.id
  cidr_block = "10.0.0.0/28"

  tags = {
    Name = "cci-workshop"
  }
}

# Security Group
resource "aws_security_group" "concourse" {
  name        = "${var.prefix}-concourse"
  description = "concourse host Security Group"
  vpc_id      = aws_vpc.cci.id
}

resource "aws_security_group_rule" "concourse_egress" {
  description       = "Allow concourse to talk to anything it likes in 10.0.0.0/24"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["10.0.0.0/24"]
  security_group_id = aws_security_group.concourse.id
}

resource "aws_security_group_rule" "concourse_https_ingress" {
  description       = "Allow Concourse to accept HTTPS requests to its web server"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/24"]
  security_group_id = aws_security_group.concourse.id
}

resource "aws_iam_role" "concourse" {
  name               = "${var.prefix}-concourse-ec2"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "AssumeRoleForConcourseInstanceProfile"
    }
  ]
}
EOF

  tags = {
    Name = "${var.prefix}-concourse-ec2"
  }
}

resource "aws_iam_instance_profile" "concourse_profile" {
  name = "${var.prefix}-concourse-ec2"
  role = aws_iam_role.concourse.id
}

resource "aws_iam_policy_attachment" "admin_access" {
  name = "${var.prefix}-concourse-ec2"
  roles = [
    aws_iam_role.concourse.id
  ]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_instance" "concourse" {
  ami                         = ""
  instance_type               = "t3.medium"
  subnet_id                   = aws_subnet.cci.id
  vpc_security_group_ids      = [aws_security_group.concourse.id]
  iam_instance_profile        = aws_iam_instance_profile.concourse_profile.id
  user_data_replace_on_change = true

  user_data = templatefile("user_data.tftpl", {
    external_host_name = local.concourse_hostname
    admin_username     = var.concourse_username
    admin_password     = random_password.concourse_password.result
    # TODO: add proper cert:
    tls_cert = "foo"
    tls_key  = "bar"
  })

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = "2"
  }

  tags = {
    Name = "concourse-workshop-host"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.concourse.id
  allocation_id = aws_eip.concourse.id
}

resource "aws_eip" "concourse" {
  vpc = true
}
resource "aws_route53_record" "concourse_dns_record" {
  name    = local.concourse_hostanme_prefix
  zone_id = data.aws_route53_zone.ak_training.id
  ttl     = "5"
  type    = "A"
  records = [aws_eip.concourse.public_ip]
}
