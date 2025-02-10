provider "aws" {
  region = "ap-southeast-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "ec2_example" {
  ami = "ami-0095e05a7e9619643"
  instance_type = var.instance_type

  tags = {
    Name = "Terraform EC2"
  }
}