variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "public_key" {}
variable "tags" {}
variable "user_data_install_jenkins" {}
variable "public_ip" {}
variable "sg_for_jenkins" {}


output "jenkins_ec2_instance_id" {
    value = aws_instance.jenkins_ec2_instance.id 
}
resource "aws_instance" "jenkins_ec2_instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = var.tags
    key_name = "aws_ec2_terraform"
    subnet_id = var.subnet_id
    associate_public_ip_address = var.public_ip
    vpc_security_group_ids = var.sg_for_jenkins
    user_data = var.user_data_install_jenkins

    metadata_options {
        http_tokens = "required"
        http_put_response_hop_limit = 1
        http_endpoint = "enabled"
    }
}

resource "aws_key_pair" "jenkis_ec2_instance_public_key" {
    key_name = "aws_ec2_terraform"
    public_key = var.public_key

}