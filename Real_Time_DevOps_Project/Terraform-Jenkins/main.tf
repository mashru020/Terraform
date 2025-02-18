module "networking" {
    source = "./networking"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    availability_zones = var.availability_zones
}

module "security-group" {
    source = "./security-group"
    vpc_id = module.networking.dev_proj_1_jenkins_vpc_id
    ec2_sg_name = "SG for ssh 22, http 80, https 443"
    ec2_sg_jenkins_name = "SG for Jenkins 8080"
}

module "jenkins" {
    source = "./jenkins"
    ami_id = var.ec2_ami_id
    instance_type = "t2.medium"
    public_key = var.public_key
    subnet_id = tolist(module.networking.dev_proj_1_jenkins_public_subnet_ids)[0]
    sg_for_jenkins = [module.security-group.ec2_sg_jenkins_id, module.security-group.ec2_sg_id]
    public_ip = true
    tags = { Name = "Jenkins:Ubuntu Linux EC2" }
    user_data_install_jenkins = templatefile("./jenkins-runner-script/jenkins-installer.sh", {})
}

module "lb_target_group" {
    source = "./load-balancer-target-group"
    vpc_id = module.networking.dev_proj_1_jenkins_vpc_id
    target_group_name = "jenkins-lb-target-group"
    target_group_port = 8080
    target_group_protocol = "HTTP"
    ec2_instance_id = module.jenkins.jenkins_ec2_instance_id
}

# module "alb" {
#     source = "./load-balancer"
#     lb_name = "dev-proj-1-alb"
#     is_external = false
#     lb_type = "application"
#     enable_http_ssh = module.security-group.ec2_sg_id
#     subnet_ids = tolist(module.networking.dev_proj_1_jenkins_public_subnet_ids)
#     tag_name = "dev-proj-1-alb"
#     lb_target_group_arn = module.lb_target_group.dev_porj_1_lb_target_group_arn
#     ec2_instance_id = module.jenkins.jenkins_ec2_instance_id
#     lb_listener_port = 80
#     lb_listener_protocol = "HTTP"
#     lb_listener_default_action = "forward"
#     lb_target_group_attachment_port = 8080
# }

module "alb" {
    source = "./load-balancer"
    lb_name = "dev-proj-1-alb"
    is_external = false
    lb_type = "application"
    sg_enable_ssh_http = module.security-group.ec2_sg_id
    subnet_ids = tolist(module.networking.dev_proj_1_jenkins_public_subnet_ids)
    tag_name = "dev-proj-1-alb"
    lb_target_group_arn = module.lb_target_group.dev_porj_1_lb_target_group_arn
    ec2_instance_id = module.jenkins.jenkins_ec2_instance_id
    lb_listener_port = 80
    lb_listener_protocol = "HTTP"
    lb_listener_default_action = "forward"
    lb_https_listener_port = 443
    lb_https_listener_protocol = "HTTPS"
    lb_target_group_attachment_port = 8080
}