#RDS INSTANCE
resource "aws_db_instance" "shared_psql_rds_instance" {
  identifier                = "${var.prefix}-psql-shared-db-${var.environment}"
  engine                    = var.shared_psql_db_engine
  engine_version            = var.shared_psql_db_version
  instance_class            = var.shared_psql_db_instance_class
  vpc_security_group_ids    = [aws_security_group.shared_psql_rds_instance.id]
  db_subnet_group_name      = var.shared_rds_db_subnet_group
  publicly_accessible       = false
  db_name                   = var.shared_psql_db_name
  username                  = var.shared_psql_db_username
  password                  = var.shared_psql_db_password
  backup_retention_period   = var.shared_psql_db_backup_retention_days
  backup_window             = var.shared_psql_db_backup_window
  allocated_storage         = var.shared_psql_db_allocated_storage
  storage_encrypted         = var.shared_psql_encrypted_db
  parameter_group_name      = aws_db_parameter_group.shared_psql_rds_instance.id
  maintenance_window        = var.shared_psql_db_maintenance_window
  apply_immediately         = false
  deletion_protection       = true
  copy_tags_to_snapshot     = true
  final_snapshot_identifier = "${var.prefix}-psql-shared-instance-${random_string.snapshot_suffix.result}-${var.environment}"
  tags = merge(
    var.tags, {
      managed_by  = "terraform"
      owner       = "shared"
      environment = var.environment
      auto_onoff  = var.auto_onoff
  })
}

#RDS CONFIGURATIONS
resource "aws_db_parameter_group" "shared_psql_rds_instance" {
  name   = "${var.prefix}-shared-psql-db-custom-pm-${var.environment}"
  family = var.shared_psql_db_parameter_group_family
}

resource "random_string" "snapshot_suffix" {
  length  = 8
  special = false
}

#RDS SECURITY
resource "aws_security_group" "shared_psql_rds_instance" {
  vpc_id = var.vpc_id
  name   = "${var.prefix}-shared-psql-db-${var.environment}"

  ingress {
    protocol        = "tcp"
    from_port       = 5432
    to_port         = 5432
    security_groups = var.security_group_ids_to_allow
  }

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = var.private_subnet_cidrs
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
      owner       = "shared"
      environment = var.environment
  })
}