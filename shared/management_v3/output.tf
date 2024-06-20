output "api_gateway_id" {
  value = aws_api_gateway_rest_api.management_v3.id
}

output "api_gateway_root_r_id" {
  value = aws_api_gateway_rest_api.management_v3.root_resource_id
}

output "lb_target_group_arn" {
  value = aws_lb_target_group.alb_app_tg.arn
}

output "lb_http_listener_arn" {
  value = aws_lb_listener.http_listener.arn
}

output "load_balancer_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "aws_lb_private_alb" {
  value = aws_lb.private_alb.dns_name
}

output "api_gtw_vpc_link_id" {
  value = aws_api_gateway_vpc_link.vpclink.id
}