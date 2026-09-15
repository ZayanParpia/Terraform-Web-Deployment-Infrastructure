#ALB

resource "aws_lb" "Terraform_ALB" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Security_Rules.id]
  subnets            = [aws_subnet.Terraform_Web_Subnet_A.id, aws_subnet.Terraform_Web_Subnet_B.id]

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.terraform-capstone-s3-alb.id
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "Development"
  }
}

#TARGET GROUP
resource "aws_lb_target_group" "target_group" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.Terraform_Web_Vpc.id
}


#LISTENER

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.Terraform_ALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_target_group.arn
  }
}