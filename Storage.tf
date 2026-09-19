#S3 Bucket Creation for EC2 Servers

resource "aws_s3_bucket" "terraform-capstone-s3" {
  bucket = "terraform-capstone-s3"

  tags = {
    Name        = "Terraform_Capstone_S3"
    Environment = "Dev"
  }
}

#ALB Logs

resource "aws_s3_bucket" "terraform-capstone-s3-alb-logs" {
  bucket = "terraform-capstone-s3-alb-logs"

  tags = {
    Name        = "Terraform_Capstone_S3-ALB"
    Environment = "Dev"
  }
}

#S3 Encryption
# resource "aws_kms_key" "terraform-capstone-s3-kms" {
#   description             = "This key is used to encrypt the S3 bucket for Terraform Capstone project for the s3 buckets"
#   deletion_window_in_days = 10
# }


# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-capstone-s3-encryption" {
#   bucket = aws_s3_bucket.terraform-capstone-s3.id

#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = aws_kms_key.terraform-capstone-s3-kms.arn
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }