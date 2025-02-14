module "networking" {
  source = "./networking"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  cidr_private_subnet = var.cidr_private_subnet
  cidr_public_subnet =  var.cidr_public_subnet
  availability_zone = var.availablity_zone
}

module "security_group" {
  source = "./security-group"
  ec2_sg_name = "SG for EC2 to enable SSH(22), HTTP(80) and HTTPS (443)"
  vpc_id = module.networking.dev_proj_1_vpc_id
  ec2_jenkins_sg_name = "Allow port 8080 for Jenkins"
}