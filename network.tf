
#VPC 
resource "aws_vpc" "Terraform_Web_Vpc" {
  cidr_block = "10.0.0.0/16"
}

#Private Subnet 1 (us-east-1a)

resource "aws_subnet" "Terraform_Web_Subnet_A" {
  vpc_id     = aws_vpc.Terraform_Web_Vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet A"
  }
}

#Private Subnet 2 (us-east-1b)

resource "aws_subnet" "Terraform_Web_Subnet_B" {
  vpc_id     = aws_vpc.Terraform_Web_Vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "Subnet B"
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.Terraform_Web_Vpc.id
}

#IGW  

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Terraform_Web_Vpc.id

  tags = {
    Name = "main"
  }
}

#Route Table

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.Terraform_Web_Vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "example"
  }
}

#Route Table Assosiation
resource "aws_route_table_association" "rt_assosiation" {
  subnet_id      = aws_subnet.Terraform_Web_Subnet_A.id
  route_table_id = aws_route_table.RT.id
}




