variable "vpc_cidr" {}
variable "vpc_name" {}
variable "public_subnet_cidrs" {}
variable "private_subnet_cidrs" {}
variable "availability_zones" {}

output "dev_proj_1_jenkins_vpc_id" {
  value = aws_vpc.dev_proj_1_jenkins_vpc.id
}

output "dev_proj_1_jenkins_public_subnet_ids" {
  value = aws_subnet.dev_proj_1_jenkins_public_subnets[*].id
}

output "dev_proj_1_jenkins_public_subnet_cidrs" {
  value = aws_subnet.dev_proj_1_jenkins_public_subnets[*].cidr_block
}

resource "aws_vpc" "dev_proj_1_jenkins_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
  
}

resource "aws_subnet" "dev_proj_1_jenkins_public_subnets" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.dev_proj_1_jenkins_vpc.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.vpc_name}_public_subnet_${count.index}"
  }
}

resource "aws_subnet" "dev_proj_1_jenkins_private_subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.dev_proj_1_jenkins_vpc.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.vpc_name}_private_subnet_${count.index}"
  }
}

resource "aws_internet_gateway" "dev_proj_1_jenkins_igw" {
  vpc_id = aws_vpc.dev_proj_1_jenkins_vpc.id
  tags = {
    Name = "${var.vpc_name}_igw"
  }
}

resource "aws_route_table" "dev_proj_1_jenkins_public_route_table" {
  vpc_id = aws_vpc.dev_proj_1_jenkins_vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.dev_proj_1_jenkins_igw.id
    }
    tags = {
      Name = "${var.vpc_name}_public_route_table"
    }
}

resource "aws_route_table_association" "dev_proj_1_jenkins_public_route_table_association" {
  count = length(var.public_subnet_cidrs)
  subnet_id = aws_subnet.dev_proj_1_jenkins_public_subnets[count.index].id
  route_table_id = aws_route_table.dev_proj_1_jenkins_public_route_table.id
}

resource "aws_route_table" "dev_proj_1_jenkins_private_route_table" {
  vpc_id = aws_vpc.dev_proj_1_jenkins_vpc.id
  tags = {
    Name = "${var.vpc_name}_private_route_table"
  }
}

resource "aws_route_table_association" "dev_proj_1_jenkins_private_route_table_association" {
  count = length(var.private_subnet_cidrs)
  subnet_id = aws_subnet.dev_proj_1_jenkins_private_subnets[count.index].id
  route_table_id = aws_route_table.dev_proj_1_jenkins_private_route_table.id 
}
