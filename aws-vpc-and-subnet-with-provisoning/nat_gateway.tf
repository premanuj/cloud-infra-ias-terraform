# Create NAT Gateway (with external IP) - use this by EC2 in private subnet


# 1. Define EIP
resource "aws_eip" "custom_nat" {
    domain = "vpc"
}

resource "aws_nat_gateway" "custom_nat_gw" {
  allocation_id = aws_eip.custom_nat.id
  subnet_id = aws_subnet.custom_vpc_pub_1.id
  depends_on = [ aws_internet_gateway.custom_vpc_igw ]
}

resource "aws_route_table" "custom_rt_private" {
  vpc_id = aws_vpc.custom_vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.custom_nat_gw.id
  }
  tags = {
    Name = "custom_rt_private"
  }
}

# Route Association for Private subnet

resource "aws_route_table_association" "custom_vpc_private_1-a" {
  subnet_id = aws_subnet.custom_vpc_private_1.id
  route_table_id = aws_route_table.custom_rt_private.id
}