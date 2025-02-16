variable "ec2_sg_name" {}
variable "ec2_sg_jenkins_name" {}
variable "vpc_id" {}


output "ec2_sg_jenkins_id" {
    value = aws_security_group.ec2_sg_jenkins.id
}
output "ec2_sg_id" {
    value = aws_security_group.ec2_sg.id
  
}
resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id
  name = var.ec2_sg_name
  description = "Allow inbound traffic on port 22, 80, 443"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
        Name = var.ec2_sg_name
    }
}

resource "aws_security_group" "ec2_sg_jenkins" {
    vpc_id = var.vpc_id
    name = var.ec2_sg_jenkins_name
    description = "Allow inbound traffic on port 8080"
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }
    tags = {
        Name = var.ec2_sg_jenkins_name
    }
}