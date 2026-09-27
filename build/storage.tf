# ============================================================
# S3 Buckets
# ============================================================


resource "aws_s3_bucket" "terraform-capstone-s3" {
  bucket = "terraform-capstone-s3"

  tags = {
    Name        = "Terraform_Capstone_S3"
    Environment = "Dev"
  }
}

# ============================================================
# Block Public Access
# ============================================================

resource "aws_s3_bucket_public_access_block" "ec2_s3_access" {
  bucket = aws_s3_bucket.terraform-capstone-s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "logs_s3_access" {
  bucket = aws_s3_bucket.terraform-capstone-s3-logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ============================================================
# ALB & Flow Logs
# ============================================================

resource "aws_s3_bucket" "terraform-capstone-s3-logs" {
  bucket = "terraform-capstone-s3-logs"

  tags = {
    Name        = "Terraform_Capstone_S3-Logs"
    Environment = "Dev"
  }
}
