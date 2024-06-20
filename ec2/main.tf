module "solides-academy_cloudfront" {
  source                  = "git::https://oauth2:glpat-tac1YMf4zMhvkr8souEu@gitlab.com/solides/devops/iac/shared_modules/tf_modules.git//cloudfront"
  prefix                  = var.prefix
  environment             = var.environment
  app_name                = var.app_name
  owner                   = var.owner
  team                    = var.team
  application_domain_name = var.application_domain_name
  origin_id               = module.solides-academy_ec2_instance.ec2_instance_id
  origin_domain_name      = module.solides-academy_ec2_instance.ec2_public_dns
  acm_certificate_arn     = var.acm_certificate_arn
  behaviors = jsondecode(templatefile("./templates/cloudfront_behaviors.json", {
    origin_domain_name = module.solides-academy_ec2_instance.ec2_public_dns
  }))
  depends_on = [
    module.solides-academy_ec2_instance
  ]

}

module "solides-academy_ec2_instance" {
  source             = "git::https://oauth2:glpat-tac1YMf4zMhvkr8souEu@gitlab.com/solides/devops/iac/shared_modules/tf_modules.git//ec2/instance/"
  prefix             = var.prefix
  environment        = var.environment
  app_name           = var.app_name
  auto_onoff         = var.auto_onoff
  owner              = var.owner
  team               = var.team
  ami                = var.ami
  instance_type      = var.instance_type
  keypair            = var.keypair
  public_ip          = var.public_ip
  target_subnet_id   = var.target_subnet_id
  root_ebs_encrypted = var.root_ebs_encrypted
  root_ebs_size      = var.root_ebs_size
  root_ebs_type      = var.root_ebs_type
  security_group_ids = module.solides-academy_security_group.security_group_id

}


module "solides-academy_security_group" {
  source      = "git::https://oauth2:glpat-tac1YMf4zMhvkr8souEu@gitlab.com/solides/devops/iac/shared_modules/tf_modules.git//ec2/security_group/"
  prefix      = var.prefix
  environment = var.environment
  app_name    = var.app_name
  owner       = var.owner
  team        = var.team
  vpc_id      = var.vpc_id
  ingress_rules = jsondecode(templatefile("./templates/ingress_rules.json", {
    aws_production_cidr = var.aws_production_cidr
    solides_onpremise = var.solides_onpremise
    solides_vpn = var.solides_vpn
  }))

}