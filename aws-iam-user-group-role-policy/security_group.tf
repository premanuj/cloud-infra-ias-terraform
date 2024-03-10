data "http" "my_ip" {
  url = "https://api64.ipify.org?format=json"
}

locals {
  decoded_ip = jsondecode(data.http.my_ip.response_body)["ip"] // make sure this IP is IPV4 IP. Otherwise there is no use of this IP.
} 

resource "aws_security_group" "allow_custom_ssh" {
  name        = "allow_custom_ssh"
  description = "SG for SSH Conn"
  # vpc_id      = "${aws_vpc.custom_vpc.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Don't use public cidr block in real world
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Test instance SG"
  }
}


output "security_groups" {
  value = aws_security_group.allow_custom_ssh.id
}
