# Create terraform.tfvars in directory to override the default value of variables

variable "PROFILE" {
  type = string
  default = "default"
}

variable "REGION" {
  type = string
  default = "us-west-1"
}

variable "INSTANCE_TYPE" {
  type = string
  default = "t2.micro"
}

variable "PATH_TO_PRIVATE_KEY" {
    default = "keys/ec2key"
  }

variable "PATH_TO_PUBLIC_KEY" {
    default = "keys/ec2key.pub"
  }

variable "INSTANCE_USERNAME" {
    default = "ec2-user"
  }

