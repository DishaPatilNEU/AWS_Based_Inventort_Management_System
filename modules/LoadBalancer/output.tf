output "DNS_LoadBalancer" {
  value = aws_lb.webapp_application_lb.dns_name
}

output "LBTargetGroupARN" {
  value = aws_lb_target_group.webapp_lb_target_group.arn
}

output "LBZoneID" {
  value = aws_lb.webapp_application_lb.zone_id
}