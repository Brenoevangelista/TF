tags = {
      managed_by  = "terraform"
      app_name    = ""
      owner       = ""
      environment = "staging"
      auto_onoff  = "true"
      }
prefix = "sld"
environment = "stg"
app_name = ""
owner = ""
auto_onoff = "true"
vpc_id = "vpc-0b43acd358776bbe2"
rds_private_subnet_group = "subnet-group-internal-stg"
db_instance_class = "db.t4g.small"
db_engine = "postgres"
db_version = "16.3"
db_username = "postgres"
db_name = ""
db_password = ""
aws_db_parameter_group_family = "postgres16"
encrypted_db = "true"
db_allocated_storage = "30"
db_maintenance_window = ""
db_backup_window = ""
db_backup_retention_days = "1"

ingress_rules = [
  {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["10.0.16.0/20","10.81.234.0/24","172.16.0.0/16"]
  }
]
