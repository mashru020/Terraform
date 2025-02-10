provider "aws" {
  region = "ap-southeast-1"
  access_key = ""
  secret_key = ""
}


resource "aws_instance" "ec2_example" {
  ami = "ami-0095e05a7e9619643"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform EC2"
  }
}

output "my_console_output" {
    value = aws_instance.ec2_example.public_ip
    sensitive = true
}