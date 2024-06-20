tags = {
      managed_by  = "terraform"
      app_name    = ""
      owner       = ""
      environment = "production"
      auto_onoff  = "false"
      }
prefix = "sld"
environment = "prd"
app_name = ""
owner = ""
auto_onoff = "false"
vpc_id = "vpc-0e6c6775ce3870f8a"
rds_private_subnet_group = "rds-subnet-private"
db_instance_class = "db.t4g.small"
db_engine = "postgres"
db_version = "16.3"
db_username = "postgres"
db_name = ""
db_password = ""
aws_db_parameter_group_family = "postgres16"
encrypted_db = "true"
db_allocated_storage = "100"
db_maintenance_window = ""
db_backup_window = ""
db_backup_retention_days = "7"
ingress_rules = [
  {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["10.10.0.0/20","10.81.234.0/24","172.16.0.0/16","172.31.0.0/16"]
  }
]