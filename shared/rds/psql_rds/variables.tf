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

variable "owner" {
  description = "Application Owner's email address"
}

variable "vpc_id" {
  description = "AWS VPC ID"
}

variable "private_subnet_cidrs" {
  description = "AWS Private Subnets CIDRs"
}

variable "auto_onoff" {
  description = "Boolean to auto start and stop a resource"
}

variable "shared_psql_db_parameter_group_family" {
  description = "Parameter group database family, ex; postgres13, mysql8, etc"
}

variable "shared_psql_db_instance_class" {
  description = "RDS Database instance class"
}

variable "shared_psql_db_engine" {
  description = "RDS Database engine"
}

variable "shared_psql_db_version" {
  description = "RDS Database engine version"
}

variable "shared_psql_db_username" {
  description = "RDS Database username"
}

variable "shared_psql_db_name" {
  description = "RDS Database name"
}

variable "shared_psql_db_password" {
  description = "RDS Database password"
}

variable "shared_psql_db_maintenance_window" {
  description = "RDS Database maintenance window"
}

variable "shared_psql_encrypted_db" {
  description = "RDS Database encryption (boolean) on/off"
}

variable "shared_psql_db_allocated_storage" {
  description = "RDS Database storage size"
}

variable "shared_psql_db_backup_window" {
  description = "RDS Database backup window"
}

variable "shared_psql_db_backup_retention_days" {
  description = "RDS Database snapshots retention in days"
}

variable "shared_rds_db_subnet_group" {
  description = "RDS Database shared subnet group name"
}

variable "security_group_ids_to_allow" {
  description = "ECS Service Security Group ID"
}
