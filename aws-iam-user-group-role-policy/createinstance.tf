

data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu"{
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "ec2key"{
    key_name = "ec2key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
  }


resource "aws_instance" "ec2instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.INSTANCE_TYPE
  availability_zone = data.aws_availability_zones.available.names[0]
  key_name = aws_key_pair.ec2key.key_name
  iam_instance_profile = aws_iam_instance_profile.s3-role-instance-profile.name
  vpc_security_group_ids = [aws_security_group.allow_custom_ssh.id]
  tags = {
    Name: "Test instance"
  }
      connection {
        host = coalesce(self.public_ip, self.private_ip)
        type = "ssh"
        user = var.INSTANCE_USERNAME
        private_key = file(var.PATH_TO_PRIVATE_KEY)
      }
}

output "public_ip" {
  value = aws_instance.ec2instance.public_ip
}
