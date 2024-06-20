resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags       = merge(local.common_tags, { Name = "VPC-DADOS" })
}
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.common_tags, { Name = "IGW-VPC-DADOS" })
}
resource "aws_subnet" "this" {
  for_each = {
    "pub_a" : ["${var.subnet_public_az1a}", "${var.aws_region}a", "SBNT-VPC-DADOS-PUBLIC-APP-AZ1a"]
    "pub_b" : ["${var.subnet_public_az1b}", "${var.aws_region}b", "SBNT-VPC-DADOS-PUBLIC-APP-AZ1b"]
    "pvt_a" : ["${var.subnet_private_app_az1a}", "${var.aws_region}a", "SBNT-VPC-DADOS-PRIVATE-APP-AZ1a"]
    "pvt_b" : ["${var.subnet_private_app_az1b}", "${var.aws_region}b", "SBNT-VPC-DADOS-PRIVATE-APP-AZ1b"]
    "db_a" : ["${var.subnet_private_db_az1a}", "${var.aws_region}a", "SBNT-VPC-DADOS-PRIVATE-DB-AZ1a"]
    "db_b" : ["${var.subnet_private_db_az1b}", "${var.aws_region}b", "SBNT-VPC-DADOS-PRIVATE-DB-AZ1b"]
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value[0]
  availability_zone = each.value[1]

  tags = merge(local.common_tags, { Name = each.value[2] })
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.common_tags, { Name = "RTB-VPC-DADOS-PUBLIC-APP" })
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags   = merge(local.common_tags, { Name = "RTB-VPC-DADOS-PRIVATE-APP" })
}
resource "aws_route_table_association" "private" {
  for_each = local.subnet_ids

  subnet_id      = each.value
  route_table_id = substr(each.key, 0, 3) == "PRIVATE-APP" ? aws_route_table.private.id : aws_route_table.public.id
}
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }  
  tags   = merge(local.common_tags, { Name = "RTB-VPC-DADOS-PRIVATE-DB" })
}
resource "aws_route_table_association" "database" {
  for_each = local.subnet_ids

  subnet_id      = each.value
  route_table_id = substr(each.key, 0, 3) == "PRIVATE-DB" ? aws_route_table.database.id : aws_route_table.public.id
}
resource "aws_eip" "natgw_eip" {
  vpc = true
  depends_on = [aws_internet_gateway.this]
  lifecycle {
    create_before_destroy = true
  }  
  tags   = merge(local.common_tags, { Name = "EIP-DADOS" })
}
resource "aws_nat_gateway" "natgw" {
  subnet_id     = aws_subnet.this["pub_a"].id
  allocation_id = aws_eip.natgw_eip.id
  tags   = merge(local.common_tags, { Name = "NATGW-DADOS" })
}
resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.common_tags, { Name = "VPG-VPC-DADOS" })
}
resource "aws_customer_gateway" "customer_gateway_americantower" {
  bgp_asn    = 65000
  ip_address = "186.248.174.234"
  type       = "ipsec.1"
  tags   = merge(local.common_tags, { Name = "CG-VPC-DADOS-AMERICAN-TOWER" })
}
resource "aws_customer_gateway" "customer_gateway_mundivox" {
  bgp_asn    = 65000
  ip_address = "187.111.17.154"
  type       = "ipsec.1"
  tags   = merge(local.common_tags, { Name = "CG-VPC-DADOS-MUNDIVOX" })
}
resource "aws_vpn_connection" "americantower" {
  vpn_gateway_id      = aws_vpn_gateway.vpn_gateway.id
  customer_gateway_id = aws_customer_gateway.customer_gateway_americantower.id
  type                = "ipsec.1"
  static_routes_only  = true
  tags   = merge(local.common_tags, { Name = "VPN-SITE-TO-SITE-VPC-DADOS-AMERICAN-TOWER" })
}
resource "aws_vpn_connection" "mundivox" {
  vpn_gateway_id      = aws_vpn_gateway.vpn_gateway.id
  customer_gateway_id = aws_customer_gateway.customer_gateway_mundivox.id
  type                = "ipsec.1"
  static_routes_only  = true
  tags   = merge(local.common_tags, { Name = "VPN-SITE-TO-SITE-VPC-DADOS-MUNDIVOX" })
}

resource "aws_vpn_connection_route" "americantower" {
  destination_cidr_block = "10.81.234.0/24"
  vpn_connection_id     = aws_vpn_connection.americantower.id
}

resource "aws_vpn_connection_route" "americantower2" {
  destination_cidr_block = "172.16.0.0/16"
  vpn_connection_id     = aws_vpn_connection.americantower.id
}

resource "aws_vpn_connection_route" "mundivox" {
  destination_cidr_block = "10.81.234.0/24"
  vpn_connection_id      = aws_vpn_connection.mundivox.id
}

resource "aws_vpn_connection_route" "mundivox2" {
  destination_cidr_block = "172.16.0.0/16"
  vpn_connection_id      = aws_vpn_connection.mundivox.id
}