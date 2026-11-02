#WAF CONFIG

resource "aws_wafv2_web_acl" "terraform_capstone_web_acl" {
  name        = "terraform-capstone-web-acl"
  description = "WAF for my Terraform Capstone project"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "rate-limit-per-ip"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 100
        aggregate_key_type = "IP"
        evaluation_window_sec = 60
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "rate-limit-per-ip"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "terraform-capstone-web-acl"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_web_acl_association" "terraform_capstone_web_acl_association" {
  resource_arn = aws_lb.Terraform_ALB.arn
  web_acl_arn  = aws_wafv2_web_acl.terraform_capstone_web_acl.arn
}