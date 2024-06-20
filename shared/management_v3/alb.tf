resource "aws_lb" "private_alb" {
  name                       = "${var.prefix}-management-v3-alb-${var.environment}"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = var.vpc_private_subnets_ids
  enable_deletion_protection = true

  tags = merge(
    var.tags, {
      app_name    = "management-v3"
      managed_by  = "terraform"
      environment = var.environment
      owner       = var.owner
  })
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.prefix}-management-v3-alb-${var.environment}"
  description = "Allow HTTPS inbound traffic"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = merge(
    var.tags, {
      app_name    = "management-v3"
      managed_by  = "terraform"
      environment = var.environment
      owner       = var.owner
  })
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.private_alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener" "host_http_listener" {
  load_balancer_arn = aws_lb.private_alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "404"
    }
  }
}

resource "aws_lb_target_group" "alb_app_tg" {
  name        = "${var.prefix}-management-v3-tg-${var.environment}"
  port        = "80"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200,401"
    timeout             = "5"
    path                = "/"
  }

  tags = merge(
    var.tags, {
      app_name    = "management-v3"
      managed_by  = "terraform"
      environment = var.environment
      owner       = var.owner
  })
}