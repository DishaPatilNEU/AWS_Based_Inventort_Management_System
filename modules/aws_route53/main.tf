data "aws_route53_zone" "route53_hostedZone"{
    name = var.route53_url
}

resource "aws_route53_record" "Route53_webapp"{
    zone_id =data.aws_route53_zone.route53_hostedZone.id
    type ="A"
    name = ""
    alias {
    name                   = var.LB_DNS
    zone_id                = var.LBZoneID
    evaluate_target_health = true
  }
}