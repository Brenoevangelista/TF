output "dashboards_alb_sg_id" {
  value = aws_security_group.dashboards_alb_sg.id
}

output "subscription_dashboards_alb_tg_arn" {
  value = aws_lb_target_group.subscription_alb_tg.arn
}

output "turnover_dashboards_alb_tg_arn" {
  value = aws_lb_target_group.turnover_alb_tg.arn
}

output "app-breno_dashboards_alb_tg_arn" {
  value = aws_lb_target_group.app-breno_alb_tg.arn
}

output "breno-teste_dashboards_alb_tg_arn" {
  value = aws_lb_target_group.breno-teste_alb_tg.arn
}