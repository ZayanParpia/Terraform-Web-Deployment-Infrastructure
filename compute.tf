resource "aws_network_interface" "example" {
  subnet_id   = aws_subnet.Terraform_Web_Subnet_A.id
  private_ips = ["10.0.1.10"]
  security_groups = [aws_security_group.Security_Rules.id]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "test" {
  ami           = "ami-0d7f022123f8ff19d" # us-east-1
  instance_type = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name


  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Hello from Terraform User Data</h1>" > /var/www/html/index.html
              EOF

  primary_network_interface {
    network_interface_id = aws_network_interface.example.id
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}