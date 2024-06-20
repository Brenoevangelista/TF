
variable "tags" {
  description = "AWS Tags to add to all resources created (where possible); see https://aws.amazon.com/answers/account-management/aws-tagging-strategies/"
  type        = map(any)
  default     = {}
}

variable "prefix" {
  description = "Prefix for all the resources to be created"
}

variable "environment" {
  description = "Name of the application environment. e.g. development, production, staging"
}

variable "app_name" {
  description = "Application name"
}

variable "owner" {
  description = "Application Owner's email address"
}

variable "auto_onoff" {
  description = "Boolean to auto start and stop a resource"
}

variable "aws_db_parameter_group_family" {
  description = "Parameter group database family, ex; postgres13, mysql8, etc"
}

variable "vpc_id" {
  description = "AWS VPC ID"
}

variable "db_instance_class" {
  description = "RDS Database instance class"
}

variable "db_engine" {
  description = "RDS Database engine"
}

variable "db_version" {
  description = "RDS Database engine version"
}

variable "db_username" {
  description = "RDS Database username"
}

variable "db_name" {
  description = "RDS Database name"
}

variable "db_password" {
  description = "RDS Database password"
}

variable "db_maintenance_window" {
  description = "RDS Database maintenance window"
}

variable "encrypted_db" {
  description = "RDS Database encryption (boolean) on/off"
}

variable "db_allocated_storage" {
  description = "RDS Database storage size"
}

variable "db_backup_window" {
  description = "RDS Database backup window"
}

variable "db_backup_retention_days" {
  description = "RDS Database snapshots retention in days"
}

variable "rds_private_subnet_group" {
  description = "RDS Database private subnet group name"
}

variable "ingress_rules" {
  description = "Redes liberadas no SG"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
    }))
}