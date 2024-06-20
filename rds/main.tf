#RDS INSTANCE
resource "aws_db_instance" "rds_instance" {
  identifier                = "${var.prefix}-${var.app_name}-db-${var.environment}"
  engine                    = var.db_engine
  engine_version            = var.db_version
  instance_class            = var.db_instance_class
  vpc_security_group_ids    = [aws_security_group.db_rds_instance.id]
  db_subnet_group_name      = var.rds_private_subnet_group
  publicly_accessible       = false
  db_name                   = var.db_name
  username                  = var.db_username
  password                  = var.db_password
  backup_retention_period   = var.db_backup_retention_days
  backup_window             = var.db_backup_window
  allocated_storage         = var.db_allocated_storage
  storage_encrypted         = var.encrypted_db
  parameter_group_name      = aws_db_parameter_group.rds_instance.id
  maintenance_window        = var.db_maintenance_window
  apply_immediately         = false
  deletion_protection       = true
  copy_tags_to_snapshot     = true
  final_snapshot_identifier = "${var.prefix}-rds-instance-${var.environment}-${random_string.snapshot_suffix.result}"
  tags = merge(
    var.tags, {
      managed_by  = "terraform"
      app_name    = var.app_name
      owner       = var.owner
      environment = var.environment
      auto_onoff  = var.auto_onoff
  })
}

#RDS CONFIGURATIONS
resource "aws_db_parameter_group" "rds_instance" {
  name   = "${var.prefix}-${var.app_name}-${var.environment}"
  family = var.aws_db_parameter_group_family
}

resource "random_string" "snapshot_suffix" {
  length  = 8
  special = false
}

#RDS SECURITY
resource "aws_security_group" "db_rds_instance" {
  vpc_id = var.vpc_id
  name   = "${var.prefix}-${var.app_name}-db-${var.environment}"

  ingress {
    from_port       = var.ingress_rules[0].from_port
    to_port         = var.ingress_rules[0].to_port
    protocol        = var.ingress_rules[0].protocol 
    cidr_blocks     = var.ingress_rules[0].cidr_blocks
#    security_groups = var.security_group_ids
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
  tags = merge(
    var.tags, {
      managed_by  = "terraform"
      app_name    = var.app_name
      owner       = var.owner
      environment = var.environment
  })
}