data "aws_availability_zones" "available" {
  
}

resource "aws_instance" "ec2instance" {
  ami = lookup(var.AMIS, var.REGION)
  instance_type = var.INSTANCE_TYPE
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name: "Test instance"
  }
}
