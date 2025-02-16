variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}   

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)    
}

variable "availability_zones" {
  description = "The availability zones to use"
  type        = list(string)    
}

variable "ec2_ami_id" {
  description = "The AMI ID to use for the EC2 instance (ubuntu)"
  type        = string
}

variable "public_key" {
  description = "The SSH key to access EC2 instance"
  type        = string
}