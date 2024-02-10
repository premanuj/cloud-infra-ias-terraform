# Create terraform.tfvars in directory to override the default value of variables

variable "PROFILE" {
  type = string
  default = "default"
}

variable "REGION" {
  type = string
  default = "us-east-1"
}

variable "INSTANCE_TYPE" {
  type = string
  default = "t2.micro"
}

variable "AMIS" {
  type = map 
  default = {
    "us-east-1": "ami-0c7217cdde317cfec",
    "us-east-2": "ami-0748d13ffbc370c2b",
    "us-west-1": "ami-07f8b4231133414a6 ",
    "us-west-2": "ami-0a24e6e101933d294"
  }
}
