resource "aws_instance" "ec2instance" {
  count = 3
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  tags = {
    Name: "Test instance-${count.index}"
  }
}

provider "aws" {
  profile = "default" # You can use access_key and secret_key if you wish
  region = "us-east-1"
}   