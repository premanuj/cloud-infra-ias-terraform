data "aws_ip_ranges" "us_west_ip_range" {
  regions = [var.REGION]
  services = ["ec2"]
}