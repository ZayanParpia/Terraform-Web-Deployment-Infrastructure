#S3 Bucket Creation for EC2 Servers

resource "aws_s3_bucket" "terraform-capstone-s3" {
  bucket = "terraform-capstone-s3"

  tags = {
    Name        = "Terraform_Capstone_S3"
    Environment = "Dev"
  }
}

#ALB Logs

resource "aws_s3_bucket" "terraform-capstone-s3-alb" {
  bucket = "terraform-capstone-s3-alb"

  tags = {
    Name        = "Terraform_Capstone_S3-ALB"
    Environment = "Dev"
  }
}