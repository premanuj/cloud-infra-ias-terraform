data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu"{
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn*"]
  }
  //query = "sort_by(Images, &CreationDate)[].Name"
}


resource "aws_instance" "ec2instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.INSTANCE_TYPE
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name: "Test instance"
  }
}
