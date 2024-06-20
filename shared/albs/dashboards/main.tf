#DASHBOARDS ALB
resource "aws_lb" "dashboards_alb" {
  name                       = "${var.prefix}-dashboards-alb-${var.environment}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.dashboards_alb_sg.id]
  subnets                    = var.vpc_public_subnets_ids
  enable_deletion_protection = true

  tags = merge(
    var.tags, {
      managed_by  = "terraform"
      environment = var.environment
      owner       = "shared"
  })
}

resource "aws_security_group" "dashboards_alb_sg" {
  name        = "${var.prefix}-dashboards-alb-${var.environment}"
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
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags, {
      managed_by  = "terraform"
      environment = var.environment
      owner       = "shared"
  })
}

#DASHBOARDS ALB DNS RECORD
resource "aws_route53_record" "api_r53_record" {
  name    = "dashboards.${var.domain}"
  type    = "A"
  zone_id = var.main_route_53_zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_lb.dashboards_alb.dns_name
    zone_id                = aws_lb.dashboards_alb.zone_id
  }
}

#DASHBOARD ALB CONFIGS
resource "aws_lb_listener" "https_dashboards_listener" {
  load_balancer_arn = aws_lb.dashboards_alb.id
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.main_certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "404"
    }

  }
}

#SUBSCRIPTION APP ALB CONFIGS
resource "aws_lb_listener_rule" "subscription_dashboard_rules" {
  listener_arn = aws_lb_listener.https_dashboards_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.subscription_alb_tg.arn
  }

  condition {
    path_pattern {
      values = ["/subscription/sidekiq*"]
    }
  }
}

resource "aws_lb_target_group" "subscription_alb_tg" {
  name        = "${var.prefix}-subscription-dboard-${var.environment}"
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
      managed_by  = "terraform"
      environment = var.environment
      owner       = "shared"
  })
}

#TURNOVER APP ALB CONFIGS
resource "aws_lb_listener_rule" "turnover_dashboard_rules" {
  listener_arn = aws_lb_listener.https_dashboards_listener.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.turnover_alb_tg.arn
  }

  condition {
    path_pattern {
      values = ["/turnover/sidekiq*"]
    }
  }
}

resource "aws_lb_target_group" "turnover_alb_tg" {
  name        = "${var.prefix}-turnover-dboard-${var.environment}"
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
      managed_by  = "terraform"
      environment = var.environment
      owner       = "shared"
  })
}

#app-breno APP ALB CONFIGS
resource "aws_lb_listener_rule" "app-breno_dashboard_rules" {
  listener_arn = aws_lb_listener.https_dashboards_listener.arn
  priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-breno_alb_tg.arn
  }

  condition {
    path_pattern {
      values = ["/app-breno/sidekiq*"]
    }
  }
}

resource "aws_lb_target_group" "app-breno_alb_tg" {
  name        = "${var.prefix}-app-breno-dboard-${var.environment}"
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
      managed_by  = "terraform"
      environment = var.environment
      owner       = "shared"
  })
}



#breno-teste APP ALB CONFIGS
resource "aws_lb_listener_rule" "breno-teste_dashboard_rules" {
  listener_arn = aws_lb_listener.https_dashboards_listener.arn
  priority     = 97

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.breno-teste_alb_tg.arn
  }

  condition {
    path_pattern {
      values = ["/breno-teste/sidekiq*"]
    }
  }
}

resource "aws_lb_target_group" "breno-teste_alb_tg" {
  name        = "${var.prefix}-breno-teste-dboard-${var.environment}"
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
      managed_by  = "terraform"
      environment = var.environment
      owner       = "shared"
  })
}