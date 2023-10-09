resource "aws_iam_role_policy_attachment" "webapp_s3_policy_attachment" {
  policy_arn = aws_iam_policy.webapp_s3.arn
  role       = aws_iam_role.webapp_s3_role.name
}

resource "aws_iam_instance_profile" "webapp_s3_instance_profile" {
  name = "EC2-CSYE6225_profile_3"

  role = aws_iam_role.webapp_s3_role.name
}


resource "aws_iam_policy" "webapp_s3" {
  

  name        = "webapp_s3_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:Put*",
          "s3:Get*",
          "s3:Delete*"
        ]
        Resource : [
          var.AWS_S3_ARN,
          "${var.AWS_S3_ARN}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "webapp_s3_role" {
  name = "EC2-CSYE6225"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
       
        Effect = "Allow"
         Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}



resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.webapp_s3_role.name
}