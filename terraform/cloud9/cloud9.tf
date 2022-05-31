resource "aws_cloud9_environment_ec2" "ci_cd_workshop" {
  instance_type = "t3.medium"
  name          = "ci-cd-workshop"
  image_id      = "amazonlinux-2-x86_64"
  subnet_id     = aws_subnet.cloud9[0].id
}
