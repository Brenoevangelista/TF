#API GATEWAY
resource "aws_api_gateway_rest_api" "management_v3" {
  name        = "${var.prefix}-management-v3-${var.environment}"
  description = "API Gateway externo para gerenciamento de recursos da V3"
  endpoint_configuration {
    types = ["EDGE"]
  }

  tags = merge(
    var.tags, {
      app_name    = "management v3"
      managed_by  = "terraform"
      environment = var.environment
      owner       = var.owner
  })

}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.management_v3.id
  stage_name    = var.environment
}

output "url" {
  value = "${aws_api_gateway_deployment.api_gateway_deployment.invoke_url}/"
}


#API GATEWAY CONFIGS
resource "aws_api_gateway_integration" "mock_integration" {
  rest_api_id = aws_api_gateway_rest_api.management_v3.id
  resource_id = aws_api_gateway_resource.mock_resource.id
  http_method = aws_api_gateway_method.mock_method.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_resource" "mock_resource" {
  rest_api_id = aws_api_gateway_rest_api.management_v3.id
  parent_id   = aws_api_gateway_rest_api.management_v3.root_resource_id
  path_part   = "mock"
}

resource "aws_api_gateway_method" "mock_method" {
  rest_api_id   = aws_api_gateway_rest_api.management_v3.id
  resource_id   = aws_api_gateway_resource.mock_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.management_v3.id

  variables = {
    "VPCALB"  = aws_lb.private_alb.dns_name
    "VPCLINK" = aws_api_gateway_vpc_link.vpclink.id
  }

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.management_v3.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}


#API GATEWAY DOMAIN
resource "aws_api_gateway_domain_name" "gateway_domain" {
  certificate_arn = var.main_certificate_arn
  domain_name     = "api-v3.${var.domain}"
}

resource "aws_route53_record" "api_r53_record" {
  name    = aws_api_gateway_domain_name.gateway_domain.domain_name
  type    = "A"
  zone_id = var.main_route_53_zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.gateway_domain.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.gateway_domain.cloudfront_zone_id
  }
}