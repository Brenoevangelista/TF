#NETWORK LOAD BALANCER
resource "aws_lb" "nlb" {
  name               = "${var.prefix}-management-v3-nlb-${var.environment}"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.vpc_private_subnets_ids

  tags = merge(
    var.tags, {
      app_name    = "management-v3"
      managed_by  = "terraform"
      environment = var.environment
      owner       = var.owner
  })
}

resource "aws_lb_target_group" "nlb_tg" {
  name        = "${var.prefix}-management-v3-nlb-tg-${var.environment}"
  port        = "80"
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "alb"
  tags = merge(
    var.tags, {
      app_name    = "management-v3"
      managed_by  = "terraform"
      environment = var.environment
      owner       = var.owner
  })

}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.nlb_tg.arn
  target_id        = aws_lb.private_alb.arn
  port             = 80

  depends_on = [
    aws_lb_target_group.nlb_tg,
    aws_lb_listener.listener-service-alb
  ]
}

resource "aws_lb_listener" "listener-alb" {
  load_balancer_arn = aws_lb.nlb.id
  port              = "80"
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.nlb_tg.id
    type             = "forward"
  }

  depends_on = [
    aws_lb_target_group.nlb_tg
  ]
}

resource "aws_lb_listener" "listener-service-alb" {
  load_balancer_arn = aws_lb.nlb.id
  port              = "80"
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.nlb_tg.id
    type             = "forward"
  }

  depends_on = [
    aws_lb_target_group.nlb_tg
  ]
}