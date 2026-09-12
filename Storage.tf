#S3 Bucket Creation 

resource "aws_s3_bucket" "terraform-capstone-s3" {
  bucket = "terraform-capstone-s3"

  tags = {
    Name        = "Terraform_Capstone_S3"
    Environment = "Dev"
  }
}