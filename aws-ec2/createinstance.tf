resource "aws_instance" "ec2instance" {
  ami = lookup(var.AMIS, var.REGION)
  instance_type = var.INSTANCE_TYPE
  tags = {
    Name: "Test instance"
  }
}
