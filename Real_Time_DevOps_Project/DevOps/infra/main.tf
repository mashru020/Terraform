module "networking" {
    source = "./networking"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    app_public_subnet_cidrs = var.app_public_subnet_cidrs
    app_private_subnet_cidrs = var.app_private_subnet_cidrs
    availability_zones = var.availability_zones
}

module "security_group" {
    source = "./security_group"
    vpc_id = module.networking.vpc_id
    sg_name = "SG for EC2 instance for http ssh and https"
    public_subnet_cidr_blocks= module.networking.public_subnet_cidr_blocks
    sg_for_python_app = "SG for EC2 instance for python app 5000"
}