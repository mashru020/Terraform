provider "aws" {
  region = "ap-southeast-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "ec2_ecample" {
    ami = "ami-0c2e5288624699cd8"
    instance_type = var.instance_type
    count = var.instance_count

    tags = {
      Name = "Terraform EC2"
    }
}

variable "instance_type" {
    description = "Instance type t2.micro"
    type = string
    default = "t2.micro"
}

variable "instance_count" {
  description = "Number of instance"
  type = number
  default = 2
}