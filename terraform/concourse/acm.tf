# resource "aws_route53_record" "my_dns_record_vpn_server" {
#   for_each = {
#     for dvo in aws_acm_certificate.vpn_server.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = resource.aws_route53_zone.my_dns.zone_id
# }

# resource "aws_acm_certificate" "cci_cert" {
#   domain_name       = local.concourse_hostname
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_acm_certificate_validation" "cci_cert" {
#   certificate_arn         = aws_acm_certificate.cci_cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.concourse_dns_record : record.fqdn]
# }

resource "aws_acm_certificate" "cci_cert" {
  domain_name       = local.concourse_hostname
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "concourse_dns_record" {
  name    = local.concourse_hostanme_prefix
  zone_id = data.aws_route53_zone.ak_training.id
  type    = "A"

  alias {
    name                   = aws_lb.concourse.dns_name
    zone_id                = aws_lb.concourse.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "concourse_tls_verification" {
  for_each = {
    for dvo in aws_acm_certificate.cci_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.ak_training.zone_id
}

resource "aws_acm_certificate_validation" "cci_cert_validation" {
  certificate_arn         = aws_acm_certificate.cci_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.concourse_tls_verification : record.fqdn]
}
