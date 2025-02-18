variable "vpc_id" {}
variable "target_group_name" {}
variable "target_group_port" {}
variable "target_group_protocol" {}
variable "ec2_instance_id" {}

output "dev_porj_1_lb_target_group_arn" {
    value = aws_lb_target_group.dev_porj_1_lb_target_group.arn
}

resource "aws_lb_target_group" "dev_porj_1_lb_target_group" {
    name = var.target_group_name
    port = var.target_group_port
    protocol = var.target_group_protocol
    vpc_id = var.vpc_id
    target_type = "instance"
    health_check {
        path = "/login"
        port = 8080
        timeout = 2
        interval = 5
        healthy_threshold = 6
        unhealthy_threshold = 2
        matcher = "200"
    }
}

resource "aws_lb_target_group_attachment" "dev_proj_1_lb_target_group_attachment" {
    target_group_arn = aws_lb_target_group.dev_porj_1_lb_target_group.arn
    target_id = var.ec2_instance_id
    port = var.target_group_port
}