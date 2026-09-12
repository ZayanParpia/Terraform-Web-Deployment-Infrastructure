#S3 Bucket Creation 

resource "aws_s3_bucket" "Terraform_Capstone_S3" {
  bucket = "Terraform_Capstone_S3"

  tags = {
    Name        = "Terraform_Capstone_S3"
    Environment = "Dev"
  }
}