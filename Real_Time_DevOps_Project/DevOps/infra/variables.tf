variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "app_public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}

variable "app_private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)    
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "availability_zones" {
  description = "The availability zones to use"
  type        = list(string)    
}

variable "ec2_ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
}

variable "public_key" {
  description = "The public key to use for the EC2 instance"
  type        = string
  
}

variable "user_data_install_script" {
  description = "The user data script to install the application"
  type        = string
}

