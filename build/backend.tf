terraform {
  backend "s3" {
    bucket       = "terraform-capstone-s3-states"
    key          = "terraform-capstone/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
