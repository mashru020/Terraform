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