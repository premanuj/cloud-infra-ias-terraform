data "http" "my_ip" {
  url = "https://api64.ipify.org?format=json"
}

locals {
  decoded_ip = jsondecode(data.http.my_ip.response_body)["ip"]
} 

resource "aws_security_group" "allow_custom_vpc_ssh" {
  name        = "allow_custom_vpc"
  description = "SG for SSH Conn"
  vpc_id      = "${aws_vpc.custom_vpc.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [format("%s/32", local.decoded_ip)] // My IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_custom_vpc"
  }
}

resource "aws_security_group" "allow_custom_vpc_http" {
  name        = "allow_custom_vpc_http"
  description = "SG for HTTP Conn"
  vpc_id      = "${aws_vpc.custom_vpc.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [format("%s/32", local.decoded_ip)] // My IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_custom_vpc_http"
  }
}