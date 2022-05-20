data "aws_route53_zone" "ak_training" {
  name = "training.armakuni.co.uk."
}

data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}
