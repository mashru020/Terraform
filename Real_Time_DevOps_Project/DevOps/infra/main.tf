module "networking" {
    source = "./networking"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    app_public_subnet_cidrs = var.app_public_subnet_cidrs
    app_private_subnet_cidrs = var.app_private_subnet_cidrs
    availability_zones = var.availability_zones
}

module "security_group" {
    source = "./security-group"
    vpc_id = module.networking.vpc_id
    sg_name = "SG for EC2 instance for http ssh and https"
    public_subnet_cidr_blocks= module.networking.public_subnet_cidr_blocks
    sg_for_python_app = "SG for EC2 instance for python app 5000"
}

module "ec2" {
    source = "./ec2"
    ami_id = var.ec2_ami_id
    instance_type = "t2.micro"
    sg_ssh_https_id = module.security_group.sg_ssh_https_id
    app_sg_id = module.security_group.sg_for_python_app_id
    public_subnet_id = module.networking.public_subnet_ids[0]
    tag_name = "EC2 instance for python app"
    public_key = var.public_key
    enable_public_ip = true
    user_data_install_script = templatefile("./template/install.sh", {})
}

module "load_balancer_target_group" {
    source = "./load-balancer-target-group"
    vpc_id = module.networking.vpc_id
    target_group_name = "target-group-for-ec2"
    target_group_port = 5000
    target_group_protocol = "HTTP"
    ec2_instance_id = module.ec2.ec2_instance_id
}

module "alb" {
    source = "./load-balancer"
    lb_name = "alb-for-ec2"
    lb_type = "application"
    is_external = false
    sg_enabled_ssh_http = module.security_group.sg_ssh_https_id
    subnet_ids = module.networking.public_subnet_ids
    tag_name = "ALB for EC2"
    lb_target_group_arn = module.load_balancer_target_group.target_group_arn
    ec2_instance_id = module.ec2.ec2_instance_id
    lb_lister_port = 80
    lb_lister_protocol = "HTTP"
    lb_lister_default_action = "forward"
    lb_target_group_attachment_port = 5000
}

module "rds" {
    source = "./rds"
    db_subnet_group_name = "rds-subnet-group"
    subnet_groups = module.networking.private_subnet_ids
    rds_msql_sg_id = module.security_group.sg_rds_id
    sg_enabled_ssh_http_id = module.security_group.sg_ssh_https_id
    mysql_db_identifier = "mysql-db"
    mysql_db_name = "mysql-db"
    mysql_db_username = "admin"
    mysql_db_password = "admin123"
}