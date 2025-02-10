provider "aws" {
  region = "ap-southeast-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "ec2_ecample" {
    ami = "ami-0095e05a7e9619643"
    instance_type = var.instance_type
    count = var.instance_count
    associate_public_ip_address = var.enable_public_ip
    tags = var.project_environment
}

resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name = var.user_names[count.index]
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

variable "user_names" {
  description = "IAM User Names"
  type = list(string)
  default = [ "user1", "user2", "user3" ]
}

variable "enable_public_ip" {
  description = "Enable Public IP Address"
  type = bool
  default = true
}

variable "project_environment" {
  description = "Project name and environment"
  type = map(string)
  default = {
    project = "project-alpha"
    environment = "dev"
    name = "Terraform EC2"
  }
}