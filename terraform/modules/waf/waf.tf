# Create GeoIP match set
resource "aws_wafregional_geo_match_set" "geo_match_set" {
  name = "${var.app_name}${var.module_name}WafGeoSet"

  geo_match_constraint {
    type  = "Country"
    value = "${var.waf_country}"
  }
}

# Create WAF rule based on GeoIP set above
resource "aws_wafregional_rule" "waf_rule" {
  name        = "${var.waf_name}"
  metric_name = "${var.waf_metric}"

  predicate {
    data_id = "${aws_wafregional_geo_match_set.geo_match_set.id}"
    negated = false
    type    = "GeoMatch"
  }
}

# Create WAF ACL based on the rule above
resource "aws_wafregional_web_acl" "waf_acl" {
  name        = "${var.waf_name}"
  metric_name = "${var.waf_metric}"

  default_action {
    type = "BLOCK"
  }

  rule {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = "${aws_wafregional_rule.waf_rule.id}"
  }
}

# Associate WAF ACL with load balancer
resource "aws_wafregional_web_acl_association" "waf_lb" {
  resource_arn = "${var.waf_lb}"
  web_acl_id   = "${aws_wafregional_web_acl.waf_acl.id}"
}
