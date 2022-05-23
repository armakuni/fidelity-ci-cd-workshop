resource "aws_instance" "concourse" {
  ami                         = data.aws_ami.amazon-2.id
  instance_type               = "t3.medium"
  subnet_id                   = aws_subnet.cci.id
  vpc_security_group_ids      = [aws_security_group.concourse.id]
  iam_instance_profile        = aws_iam_instance_profile.concourse_profile.id
  user_data_replace_on_change = true
  key_name                    = aws_key_pair.concourse_ssh_key.key_name

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

resource "tls_private_key" "ssh_public_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "concourse_ssh_key" {
  key_name   = "concourse-host-key"
  public_key = tls_private_key.ssh_public_key.public_key_openssh
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.concourse.id
  allocation_id = aws_eip.concourse.id
  depends_on = [
    aws_internet_gateway.cci
  ]
}

resource "aws_eip" "concourse" {
  vpc = true
}
