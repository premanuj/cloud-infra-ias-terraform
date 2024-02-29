

data "aws_availability_zones" "available" {
  filter {
    name = "region-name"
    values = [var.REGION]
  }
}

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

resource "aws_instance" "ec2instance-1" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.INSTANCE_TYPE
  availability_zone = "us-west-1b"
  key_name = aws_key_pair.ec2key.key_name
  vpc_security_group_ids =  [aws_security_group.allow_custom_vpc_ssh.id, aws_security_group.allow_custom_vpc_http.id]
  subnet_id = aws_subnet.custom_vpc_pub_1.id
  tags = {
    Name: "Test instance"
  }

  provisioner "file" {
      source = "install_nginx.sh"
      destination = "/tmp/install_nginx.sh"
    }
  
  provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/install_nginx.sh",
        "sudo /tmp/install_nginx.sh"
      ]
    }

    connection {
        host = coalesce(self.public_ip, self.private_ip)
        type = "ssh"
        user = var.INSTANCE_USERNAME
        private_key = file(var.PATH_TO_PRIVATE_KEY)
      }
}


resource "aws_instance" "ec2instance-2" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.INSTANCE_TYPE
  availability_zone = "us-west-1c"
  key_name = aws_key_pair.ec2key.key_name
  vpc_security_group_ids =  [aws_security_group.allow_custom_vpc_ssh.id]
  subnet_id = aws_subnet.custom_vpc_private_1.id
  tags = {
    Name: "Test instance Private"
  }
}

output "public_ip" {
  value = aws_instance.ec2instance-1.public_ip
}

output "private_ip" {
  value = aws_instance.ec2instance-2.private_ip
}
