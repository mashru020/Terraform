variable "ami_id" {}
variable "instance_type" {}
variable "sg_ssh_https_id" {}
variable "app_sg_id" {}
variable "public_subnet_id" {}
variable "tag_name" {}
variable "public_key" {}
variable "enable_public_ip" {}
variable "user_data_install_script" {}

output "ec2_instance_id" {
    value = aws_instance.ec2.id
  
}

resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.public_subnet_id
    key_name = "ansible-home"
    vpc_security_group_ids = [var.sg_ssh_https_id, var.app_sg_id]
    tags = {
        Name = var.tag_name
    }
    associate_public_ip_address = var.enable_public_ip
    user_data = var.user_data_install_script
}

resource "aws_key_pair" "app_public_key" {
    key_name   = "ansible-home"
    public_key = var.public_key
  
}