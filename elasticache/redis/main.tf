#ELASTICACHE CLUSTER
resource "aws_elasticache_cluster" "shared_redis" {
  cluster_id           = "${var.prefix}-shared-redis-${var.environment}"
  engine               = "redis"
  node_type            = "cache.t4g.micro"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.shared_redis_pm.name
  port                 = 6379
  az_mode              = "single-az"
  subnet_group_name    = var.shared_elasticache_private_subnets
  security_group_ids   = [aws_security_group.shared_redis_cache.id]
  tags = merge(
    var.tags, {
      managed_by  = "terraform"
      environment = var.environment
  })
}

resource "aws_security_group" "shared_redis_cache" {
  name        = "${var.prefix}-shared-redis-${var.environment}"
  description = "Security group for Redis"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 6379
    to_port   = 6379
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = var.allowed_security_groups
  }

  tags = merge(
    var.tags, {
      managed_by  = "terraform"
      environment = var.environment
  })
}

resource "aws_elasticache_parameter_group" "shared_redis_pm" {
  name   = "${var.prefix}-shared-redis-pm-${var.environment}"
  family = "redis7"
}