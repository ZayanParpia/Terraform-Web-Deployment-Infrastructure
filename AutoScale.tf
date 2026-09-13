#Launch Table

resource "aws_launch_template" "Autoscale-LaunchTemplate" {
  name_prefix            = "foobar"
  image_id               = "ami-0d7f022123f8ff19d"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.Security_Rules.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Hello from Terraform User Data</h1>" > /var/www/html/index.html
              EOF
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.Terraform_Web_Subnet_A.id, aws_subnet.Terraform_Web_Subnet_B.id]


  launch_template {
    id      = aws_launch_template.Autoscale-LaunchTemplate.id
    version = "$Latest"
  }
}


resource "aws_autoscaling_policy" "autoscale-policy" {
  name                   = "autoscale-policy"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 10 #Change Later
  }
}
