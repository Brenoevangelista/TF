resource "aws_api_gateway_vpc_link" "vpclink" {
  name        = "${var.prefix}-management-v3-link-${var.environment}"
  description = "$Management v3 API Gateway VPC link ${var.environment}"
  target_arns = [aws_lb.nlb.arn]

  tags = merge(
    var.tags, {
      Name        = "${var.prefix}-management-v3-link-${var.environment}"
      app_name    = "management v3"
      managed_by  = "terraform"
      environment = var.environment
      owner       = var.owner
  })
}