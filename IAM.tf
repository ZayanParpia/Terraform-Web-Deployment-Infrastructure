# ============================================================
# EC2 IAM ROLE
# SSM + S3
# ============================================================

# Trust policy: allow EC2 to assume this role
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "test-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}


# ============================================================
# SSM PERMISSIONS
# ============================================================

resource "aws_iam_role_policy_attachment" "ssm_managed" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


# ============================================================
# S3 PERMISSIONS
# ============================================================

resource "aws_iam_role_policy" "s3_access" {
  name = "EC2-S3-Access"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]

      Resource = [
        aws_s3_bucket.terraform-capstone-s3.arn,
        "${aws_s3_bucket.terraform-capstone-s3.arn}/*"
      ]
    }]
  })
}


# ============================================================
# EC2 INSTANCE PROFILE
# ============================================================

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2-Instance-Profile"
  role = aws_iam_role.ec2_role.name
}


# ============================================================
# ALB LOGS
# ============================================================


# data "aws_iam_policy_document" "alb_logs" {
#   statement {
#     sid    = "AllowALBLogDelivery"
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["logdelivery.elasticloadbalancing.amazonaws.com"]
#     }

#     actions   = ["s3:PutObject"]
#     resources = ["${aws_s3_bucket.terraform-capstone-s3-alb-logs.arn}/alb/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

#     condition {
#       test     = "StringEquals"
#       variable = "s3:x-amz-acl"
#       values   = ["bucket-owner-full-control"]
#     }
#   }
# }

data "aws_caller_identity" "current" {}