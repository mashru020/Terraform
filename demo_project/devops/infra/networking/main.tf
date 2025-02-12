variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "cidr_private_subnet" {}
variable "availability_zone" {}

resource "aws_vpc" "dev_proj_1_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "dev_proj_1_public_subnets" {
    count = length(var.cidr_public_subnet)
    vpc_id = aws_vpc.dev_proj_1_vpc.id
    cidr_block = element(var.cidr_public_subnet, count.index)
    availability_zone = element(var.availability_zone, count.index)

    tags = {
      Name = "dev-proj-1-public-subnet-${count.index + 1}"
    }
}

resource "aws_subnet" "dev_proj_1_private_subnet" {
  count = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.dev_proj_1_vpc.id
  cidr_block = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "dev-proj-1-private-subnet-${count.index + 1}"
  }
}