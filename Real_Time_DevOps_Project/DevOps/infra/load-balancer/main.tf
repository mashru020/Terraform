variable "lb_name" {}
variable "lb_type" {}
variable "is_external" { default = false }
variable "sg_enabled_ssh_http" {}
variable "subnet_ids" {}
variable "tag_name" {}
variable "lb_target_group_arn" {}
variable "ec2_instance_id" {}
variable "lb_lister_port" {}
variable "lb_lister_protocol" {}
variable "lb_lister_default_action" {}
variable "lb_target_group_attachment_port" {}


resource "aws_lb" "app_lb" {
    name = var.lb_name
    internal = var.is_external
    security_groups = [var.sg_enabled_ssh_http]
    subnets = var.subnet_ids
    enable_deletion_protection = false
    tags = {
        Name = var.tag_name
    }   
}

resource "aws_lb_listener" "app_lb_listener" {
    load_balancer_arn = aws_lb.app_lb.arn
    port = var.lb_lister_port
    protocol = var.lb_lister_protocol

    default_action {
        type = var.lb_lister_default_action
        target_group_arn = var.lb_target_group_arn
    }
}