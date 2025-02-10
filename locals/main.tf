locals {
  staging_env="staging"
}

provider "aws" {
  region = "ap-southeast-1"
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "staging-vpc" {
  cidr_block = "10.5.0.0/16"

  tags = {
    Name = "${local.staging_env}-vpc-tag"
  }
}

resource "aws_subnet" "staging-subnet" {
    vpc_id = aws_vpc.staging-vpc.id
    cidr_block = "10.5.0.0/16"

    tags = {
      Name = "${local.staging_env}-subnet-tag"
    }
  
}

resource "aws_instance" "ec2_example" {
  ami = "ami-0095e05a7e9619643"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.staging-subnet.id

  tags = {
    Name = "${local.staging_env} - Terraform EC2"
  }
}