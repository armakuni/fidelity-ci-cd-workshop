resource "aws_lb" "concourse" {
  name               = "concourse-workshop-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.concourse.id]
  subnets            = [aws_subnet.cci[0].id, aws_subnet.cci[1].id]
}

resource "aws_lb_target_group" "concourse_tg" {
  name     = "concourse-alb-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.cci.id
}

resource "aws_lb_target_group_attachment" "concourse_ec2" {
  target_group_arn = aws_lb_target_group.concourse_tg.arn
  target_id        = aws_instance.concourse.id
  port             = 443
}

resource "aws_lb_listener" "concourse_listener" {
  load_balancer_arn = aws_lb.concourse.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cci_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.concourse_tg.arn
  }
}

resource "aws_lb_listener_certificate" "concourse_ssl" {
  listener_arn    = aws_lb_listener.concourse_listener.arn
  certificate_arn = aws_acm_certificate.cci_cert.arn
}
