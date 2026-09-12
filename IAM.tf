#SSM ROLE
# Trust policy: allow EC2 to assume this role
data "aws_iam_policy_document" "ssm_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ssm_role" {
  name               = "test-ec2-ssm-role"
  assume_role_policy = data.aws_iam_policy_document.ssm_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ssm_managed" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#S3 Bucket ROLE

resource "aws_iam_role" "ec2_s3_role" {
  name = "EC2-S3-Access-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "s3_access" {
  name = "EC2-S3-Access"
  role = aws_iam_role.ec2_s3_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
      Resource = [
        "arn:aws:s3:::YOUR-BUCKET-NAME",
        "arn:aws:s3:::YOUR-BUCKET-NAME/*"
      ]
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "EC2-S3-Instance-Profile"
  role = aws_iam_role.ec2_s3_role.name
}