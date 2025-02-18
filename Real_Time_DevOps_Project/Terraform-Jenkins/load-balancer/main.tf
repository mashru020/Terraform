variable "lb_name" {}
variable "is_external" {}
variable "lb_type" {}
variable "sg_enable_ssh_http" {}
variable "subnet_ids" {}
variable "tag_name" {}
variable "lb_target_group_arn" {}
variable "ec2_instance_id" {}
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}
variable "lb_https_listener_port" {}
variable "lb_https_listener_protocol" {}
variable "lb_listener_default_action" {}
variable "lb_target_group_attachment_port" {}


resource "aws_lb" "dev_proj_1_lb" {
    name = var.lb_name
    internal = var.is_external
    load_balancer_type = var.lb_type
    security_groups = [var.sg_enable_ssh_http]
    subnets = var.subnet_ids
    
    enable_deletion_protection = false
    tags = {
        Name = var.tag_name
    }
}

resource "aws_lb_target_group_attachment" "dev_proj_1_lb_target_group_attachment" {
    target_group_arn = var.lb_target_group_arn
    target_id = var.ec2_instance_id
    port = var.lb_target_group_attachment_port
  
}

resource "aws_lb_listener" "dev_proj_1_lb_listener" {
    load_balancer_arn = aws_lb.dev_proj_1_lb.arn
    port = var.lb_listener_port
    protocol = var.lb_listener_protocol

    default_action {
        type = var.lb_listener_default_action
        target_group_arn = var.lb_target_group_arn
    }
}

/*resource "aws_lb_listener" "dev_proj_1_https_listener" {
    load_balancer_arn = aws_lb.dev_proj_1_lb.arn
    port = var.lb_https_listener_port
    protocol = var.lb_https_listener_protocol
    ssl_policy = "ELBSecurityPolicy-2016-08"
    certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"


    default_action {
        type = var.lb_listener_default_action
        target_group_arn = var.lb_target_group_arn
    }
  
}*/