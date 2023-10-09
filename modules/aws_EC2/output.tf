output "ec2_webapp_IPAddress" {
  value = aws_instance.aws_ec2_csye6225.public_ip
}