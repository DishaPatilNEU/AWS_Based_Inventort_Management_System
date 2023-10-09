
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "internet-gateway"
  }
}


resource "aws_vpc" "vpc" {
  cidr_block = var.VPC_CIDR_Value
  tags = {
    Name = "main_vpc"
  }
}
