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

resource "aws_key_pair" "ec2key"{
    key_name = "ec2key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
  }


resource "aws_instance" "ec2instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.INSTANCE_TYPE
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name: "Test instance"
  }

  provisioner "file" {
      source = "install_nginx.sh"
      destination = "/tmp/install_nginx.sh"
    }
  
  provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/install_ngnix.sh",
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

output "public_ip" {
  value = aws_instance.ec2instance.public_ip
}

