variable "vpc_cidr" {}
variable "vpc_name" {}
variable "app_public_subnet_cidrs" {}
variable "app_private_subnet_cidrs" {}
variable "availability_zones" {}


output "public_subnet_cidr_blocks" {
  value = aws_subnet.app_public_subnet[*].cidr_block
}
output "private_subnet_cidr_blocks" {
  value = aws_subnet.app_private_subnet[*].cidr_block
}
output "vpc_id" {
  value = aws_vpc.app_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.app_public_subnet[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.app_private_subnet[*].id
  
}
resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "app_public_subnet" {
  count = length(var.app_public_subnet_cidrs)
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = element(var.app_public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "app_private_subnet" {
  count = length(var.app_private_subnet_cidrs)
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = element(var.app_private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index}"
  }
  
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "app_public_route_table" {
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
    }
    tags = {
        Name = "${var.vpc_name}-public-route-table"
    }
}

resource "aws_route_table_association" "app_public_subnet_association" {
  count = length(var.app_public_subnet_cidrs)
  subnet_id = element(aws_subnet.app_public_subnet[*].id, count.index)
  route_table_id = aws_route_table.app_public_route_table.id
}

resource "aws_route_table" "app_private_route_table" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
  
}

resource "aws_route_table_association" "app_private_subnet_association" {
  count = length(var.app_private_subnet_cidrs)
  subnet_id = element(aws_subnet.app_private_subnet[*].id, count.index)
  route_table_id = aws_route_table.app_private_route_table.id
}