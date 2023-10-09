

resource "aws_route_table_association" "public_rta" {
  count          = length(var.PublicSubnetID)
  subnet_id      = var.PublicSubnetID[count.index]
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private" {
  vpc_id = var.vpc_instance_id
  tags = {
    Name = "private_route_table"
  }
}
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_instance_id
  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "private_rta" {
  count          = length(var.PrivateSubnetID)
  subnet_id      = var.PrivateSubnetID[count.index]
  route_table_id = aws_route_table.private.id
}


