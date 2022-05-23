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

resource "aws_internet_gateway" "cci" {
  vpc_id = aws_vpc.cci.id

  tags = {
    Name = "concourse-igw"
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
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.concourse.id
}

resource "aws_security_group_rule" "concourse_ssh_ingress" {
  description       = "Allow Concourse to accept SSH requests to its host instance"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.concourse.id
}

resource "aws_security_group_rule" "concourse_https_ingress" {
  description       = "Allow Concourse to accept HTTPS requests to its web server"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
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

resource "aws_route" "concourse_udr" {
  route_table_id         = aws_vpc.cci.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.cci.id
}
