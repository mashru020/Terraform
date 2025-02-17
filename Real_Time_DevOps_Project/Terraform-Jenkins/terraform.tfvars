vpc_cidr = "11.0.0.0/16"
vpc_name = "dev_proj_1_jenkins_vpc"
public_subnet_cidrs = ["11.0.1.0/24", "11.0.2.0/24"]
private_subnet_cidrs = ["11.0.3.0/24", "11.0.4.0/24"]
availability_zones = [ "ap-southeast-1a", "ap-southeast-1b" ]

ec2_ami_id = "ami-00e45153f5e1bd2f2"
public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINFMxc+zkFKcGvLHsu80Xwi5mzsrRW2lMLwxteAgTlkz ansible"
