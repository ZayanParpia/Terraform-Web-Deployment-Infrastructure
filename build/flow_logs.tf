resource "aws_flow_log" "terraform_capstone_flow_log" {
  log_destination      = aws_s3_bucket.terraform-capstone-s3-logs.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.Terraform_Web_Vpc.id

  depends_on = [aws_s3_bucket_policy.logs_bucket]
}

