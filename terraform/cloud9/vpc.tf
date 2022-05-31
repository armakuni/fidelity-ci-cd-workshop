# VPC
resource "aws_vpc" "cloud9" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "cicd-ws-cloud9"
  }
}

# Subnets
resource "aws_subnet" "cloud9" {
  count             = 1
  vpc_id            = aws_vpc.cloud9.id
  cidr_block        = cidrsubnet(aws_vpc.cloud9.cidr_block, 2, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "cicd-ws-cloud9-${count.index}"
  }
}

# Internet gateway for external access
resource "aws_internet_gateway" "cloud9" {
  vpc_id = aws_vpc.cloud9.id

  tags = {
    Name = "cloud9-igw"
  }
}

resource "aws_route" "cloud9_udr" {
  route_table_id         = aws_vpc.cloud9.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.cloud9.id
}

# # Security Group
# resource "aws_security_group" "Cloud9" {
#   name        = "${var.prefix}-Cloud9"
#   description = "Cloud9 host Security Group"
#   vpc_id      = aws_vpc.cci.id
# }

# resource "aws_security_group_rule" "Cloud9_egress" {
#   description       = "Allow Cloud9 to talk to anything it likes in 10.0.0.0/24"
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.Cloud9.id
# }

# resource "aws_security_group_rule" "Cloud9_ssh_ingress" {
#   description       = "Allow Cloud9 to accept SSH requests to its host instance"
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.Cloud9.id
# }

# resource "aws_security_group_rule" "Cloud9_https_ingress" {
#   description       = "Allow Cloud9 to accept HTTPS requests to its web server"
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.Cloud9.id
# }

# resource "aws_iam_role" "Cloud9" {
#   name               = "${var.prefix}-Cloud9-ec2"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": "AssumeRoleForCloud9InstanceProfile"
#     }
#   ]
# }
# EOF

#   tags = {
#     Name = "${var.prefix}-Cloud9-ec2"
#   }
# }

# resource "aws_route" "Cloud9_udr" {
#   route_table_id         = aws_vpc.cci.default_route_table_id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.cci.id
# }
