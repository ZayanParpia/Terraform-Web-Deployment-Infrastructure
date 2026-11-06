#WAF CONFIG

resource "aws_wafv2_web_acl" "terraform_capstone_web_acl" {
  name        = "terraform-capstone-web-acl"
  description = "WAF for my Terraform Capstone project"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  # rule {
  #   name     = "rate-limit-per-ip"
  #   priority = 1

  #   action {
  #     block {}
  #   }

  #   statement {
  #     rate_based_statement {
  #       limit                 = 100
  #       aggregate_key_type    = "IP"
  #       evaluation_window_sec = 60
  #     }
  #   }

  #   visibility_config {
  #     cloudwatch_metrics_enabled = true
  #     metric_name                = "rate-limit-per-ip"
  #     sampled_requests_enabled   = true
  #   }
  # }

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

#CLOUDWATCH CONF
resource "aws_cloudwatch_log_group" "capstone-waf-cloudwatch-group" {
  name = "aws-waf-logs-capstone"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}

data "aws_iam_policy_document" "waf_log_delivery" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "${aws_cloudwatch_log_group.capstone-waf-cloudwatch-group.arn}:*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [aws_wafv2_web_acl.terraform_capstone_web_acl.arn]
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "waf_log_delivery" {
  policy_name     = "aws-waf-logs-delivery-policy"
  policy_document = data.aws_iam_policy_document.waf_log_delivery.json
}

resource "aws_wafv2_web_acl_logging_configuration" "cloudwatch-log-conf" {
  log_destination_configs = [
    aws_cloudwatch_log_group.capstone-waf-cloudwatch-group.arn
  ]

  resource_arn = aws_wafv2_web_acl.terraform_capstone_web_acl.arn

  depends_on = [
    aws_cloudwatch_log_resource_policy.waf_log_delivery
  ]
}