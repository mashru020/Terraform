variable "db_subnet_group_name" {}
variable "subnet_groups"   {}
variable "rds_msql_sg_id" {}
variable "sg_enabled_ssh_http_id" {}
variable "mysql_db_identifier" {}
variable "mysql_db_name" {}
variable "mysql_db_username" {}
variable "mysql_db_password" {}


resource "aws_db_instance" "rds" {
    allocated_storage = 20
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t2.micro"
    identifier = var.mysql_db_identifier
    db_name = var.mysql_db_name
    username = var.mysql_db_username
    password = var.mysql_db_password
    db_subnet_group_name = var.db_subnet_group_name
    vpc_security_group_ids = [var.rds_msql_sg_id, var.sg_enabled_ssh_http_id]
    skip_final_snapshot = true
    apply_immediately = true
    backup_retention_period = 0
    deletion_protection = false
}