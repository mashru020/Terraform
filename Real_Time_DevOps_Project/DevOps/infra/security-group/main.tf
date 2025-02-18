variable "vpc_id" {}
variable "sg_name" {}
variable "sg_for_python_app" {}
variable "public_subnet_cidr_blocks" {}

resource "aws_security_group" "sg_ssh_https" {
  vpc_id = var.vpc_id
    name = var.sg_name
    description = "Allow inbound traffic from port 22, 80, 443"
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.sg_name
    }

}

resource "aws_security_group" "sg_python_app" {
    vpc_id = var.vpc_id
    name = var.sg_for_python_app
    ingress {
        description = "Allow inbound traffic from port 5000"
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      name = var.sg_for_python_app
    }
}

resource "aws_security_group" "sg_for_rds" {
  vpc_id = var.vpc_id
  name = "SG for RDS"
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = var.public_subnet_cidr_blocks
    }

}