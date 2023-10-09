resource "aws_lb" "webapp_application_lb" {
  name                       = "webapp-application-lb"
  load_balancer_type         = "application"
  internal                   = false
  security_groups            = var.SecurityGroupID
  enable_deletion_protection = false
  subnets                    = var.LB_Subnets
  tags = {
    Application = "WebApp"
  }
}

resource "aws_lb_listener" "webapp_lb_listener" {
  load_balancer_arn = aws_lb.webapp_application_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.webapp_lb_target_group.arn
    type             = "forward"
  }
}


resource "aws_lb_listener_certificate" "my-certificate" {
  listener_arn    = aws_lb_listener.webapp_https_lb_listener.arn
  certificate_arn = data.aws_acm_certificate.ssl_certificate.arn
}

data "aws_acm_certificate" "ssl_certificate" {
  domain   = var.webapp_url
  statuses = ["ISSUED"]
}

resource "aws_lb_listener" "webapp_https_lb_listener" {
  load_balancer_arn = aws_lb.webapp_application_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.ssl_certificate.arn

  default_action {
    target_group_arn = aws_lb_target_group.webapp_lb_target_group.arn
    type             = "forward"
  }
}
resource "aws_lb_target_group" "webapp_lb_target_group" {
  name     = "example-target-group" ##change this
  port     = 3000
  protocol = "HTTP"

  vpc_id = var.VPC_ID

  health_check {
    path = "/healthz"
  }
  target_type = "instance"
}

