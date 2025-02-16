variable "ec2_sg_name" {}
variable "ec2_jenkins_sg_name" {}
variable "vpc_id" {}

resource "aws_security_group" "ec2_sg_ssh_http" {
  name = var.ec2_sg_name
  vpc_id = var.vpc_id
  description = "Enable the ssh(22) and http(443, 80) port"

  ingress {
    description = "Allow remote SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  ingress {
    description = "Allow https request to anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }

  ingress {
    description = "Allow http request to anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    to_port = 80
    from_port = 80
    protocol = "tcp"
  }

  egress {
    description = "Allow outgoing request"
    cidr_blocks = ["0.0.0.0/0"]
    to_port = 0
    from_port = 0
    protocol = -1
  }

  tags = {
    Name = "Security Group to allow 22, 80 and 443"
  }
}

resource "aws_security_group" "ec2_jenkins_security_group" {
  name = var.ec2_jenkins_sg_name
  description = "Enable 8080 port for Jenkins"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow 8080 port to access jenkins"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
  }

  tags = {
    Name = "Security Groupt to allow Jenkins"
  }
}

