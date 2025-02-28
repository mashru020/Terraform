variable "vpc_id" {}
variable "target_group_name" {}
variable "target_group_port" {}
variable "target_group_protocol" {}
variable "ec2_instance_id" {}


output "target_group_arn" {
  value = aws_lb_target_group.app_lb_target_group.arn
}

resource "aws_lb_target_group" "app_lb_target_group" {
    vpc_id = var.vpc_id
    name = var.target_group_name
    port = var.target_group_port
    protocol = var.target_group_protocol
  
    health_check {
      path = "/health"
      port = var.target_group_port
      timeout = 2
      interval = 5
      healthy_threshold = 6
      unhealthy_threshold = 2
      matcher = "200"
    }
}


resource "aws_lb_target_group_attachment" "app_lb_target_group_attachment" {
    target_group_arn = aws_lb_target_group.app_lb_target_group.arn
    target_id = var.ec2_instance_id
    port = var.target_group_port
  
}