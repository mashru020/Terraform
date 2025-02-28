vpc_cidr = "10.11.0.0/16"
vpc_name = "app-vpc"
app_public_subnet_cidrs = ["10.11.1.0/24", "10.11.2.0/24"]
app_private_subnet_cidrs = ["10.11.3.0/24", "10.11.4.0/24"]
availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]

ec2_ami_id = "ami-01e7f9c2ab8f02bd0"
instance_type = "t2.micro"

public_key = "sssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID3kozBW4XlS1B5v9PBk5uYOvYmKz+JNp+pskSHeeAkV mashru@mashru-pc"

user_data_install_script = ""