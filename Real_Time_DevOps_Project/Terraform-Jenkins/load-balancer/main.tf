variable "lb_name" {}
variable "is_external" {}
variable "lb_type" {}
variable "enable_https_ssh" {}
variable "subnet_ids" {}
variable "tag_name" {}
variable "lb_target_group_arn" {}
variable "ec2_instance_id" {}
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}
variable "lb_listener_default_action" {}
variable "lb_https_listener_port" {}
variable "lb_https_listener_protocol" {}
variable "lb_target_group_attachment_port" {}
variable "dev_porj_1_lb_target_group_arn" {}


resource "aws_lb" "dev_proj_1_lb" {
    name = var.lb_name
    internal = var.is_external
    load_balancer_type = var.lb_type
    security_groups = [var.enable_https_ssh]
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


resource "aws_lb_listener" "dev_proj_1_lb_https_listner" {
  load_balancer_arn = aws_lb.dev_proj_1_lb.arn
  port              = var.lb_https_listner_port
  protocol          = var.lb_https_listner_protocol
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = var.dev_proj_1_acm_arn

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.lb_target_group_arn
  }
}