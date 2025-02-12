
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR values"
}

variable "vpc_name" {
  type        = string
  description = "DevOps Project 1 VPC 1"
}

variable "cidr_public_subnet" {
  type = list(string)
  description = "Public Subnet CIDR values"
}

variable "cidr_private_subnet" {
  type = list(string)
  description = "Private Subnet CIDR values"
}

variable "availablity_zone" {
  type = list(string)
  description = "Availablity Zones"
}