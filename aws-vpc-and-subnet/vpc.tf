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
  enable_dns_hostnames = trur
  tags = {
    Name = "customVPC"
  }
}