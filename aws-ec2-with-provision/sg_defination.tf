# provider "https" {
  
# }

data "http" "my_ip" {
  url = "https://api64.ipify.org?format=json"
}

locals {
  decoded_ip = jsondecode(data.http.my_ip.response_body)["ip"]
} 
data "aws_ip_ranges" "us_east_ip_range" {
  regions = [var.REGION]
  services = ["ec2"]
}

# [data.http.my_ip.response_body + "/32"]
resource "aws_security_group" "sg_custom_us_east" {
  name = "sg_custom_us_east"
  ingress = [{
    cidr_blocks = concat(data.aws_ip_ranges.us_east_ip_range.cidr_blocks, [format("%s/32", local.decoded_ip)])   # Defining ip range
    from_port = 0
    to_port = 0
    protocol = -1
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
    description = "allowing https connections"
  }]
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

output "security_group_id" {
  value = aws_security_group.sg_custom_us_east.id
}

# Output the value of your dynamically retrieved public IP
output "my_ip" {
  value = jsondecode(data.http.my_ip.response_body)["ip"]
}