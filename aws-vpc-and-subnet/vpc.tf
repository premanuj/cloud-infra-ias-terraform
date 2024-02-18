# Following are the task that will be taken in action

# 1. Create AWS VPC
# 2. Create Subnet in custom VPC
# 3. Define Internet Gateway
# 4. Define Route table for VPC
# 5. Define the routing association between a route table
# and a subnet ot a route table and an internet gateway or virtual private gateway

# 1. Create a AWS VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "customVPC"
  }
}

# 2. Create Subnet in custom VPC
resource "aws_subnet" "custom_vpc_pub_1" {
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1b"

  tags = {
    "Name" = "custom_vpc_pub_1"
  }
}

resource "aws_subnet" "custom_vpc_pub_2" {
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1c"

  tags = {
    "Name" = "custom_vpc_pub_2"
  }
}

resource "aws_subnet" "custom_vpc_private_1" {
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone = "us-west-1c"

  tags = {
    "Name" = "custom_vpc_private_1"
  }
}

# 3. Define Internet Gateway
resource "aws_internet_gateway" "custom_vpc_igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "CustomVPC-IGW"
  }
}

