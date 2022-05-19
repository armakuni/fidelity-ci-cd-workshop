output "concourse_url" {
  value = "https://${aws_route53_record.concourse_dns_record.fqdn}"
}

output "concourse_ip" {
  value = aws_instance.concourse.private_ip
}

output "concourse_password" {
  value     = random_password.concourse_password.result
  sensitive = true
}
