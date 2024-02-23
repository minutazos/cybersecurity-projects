resource "aws_security_group_rule" "ProductionGroupIncomingPostgresPUAllowed" {
  # this rule is added to the security group defined by `security_group_id`
  # and this id target the `default` security group associated with the created VPC
  security_group_id = aws_security_group.ProductionGroupPUSecurityRules.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432

  # One of ['cidr_blocks', 'ipv6_cidr_blocks', 'self', 'source_security_group_id', 'prefix_list_ids']
  # must be set to create an AWS Security Group Rule
  source_security_group_id = aws_security_group.ProductionGroupPUSecurityRules.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ProductionGroupOutgoingPostgresPUAllowed" {
  # this rule is added to the security group defined by `security_group_id`
  # and this id target the `default` security group associated with the created VPC
  security_group_id = aws_security_group.ProductionGroupPUSecurityRules.id

  type      = "egress"
  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432

  # One of ['cidr_blocks', 'ipv6_cidr_blocks', 'self', 'source_security_group_id', 'prefix_list_ids']
  # must be set to create an AWS Security Group Rule
  source_security_group_id = aws_security_group.ProductionGroupPUSecurityRules.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "ProductionGroupFrontSecurityRules" {
  vpc_id = aws_vpc.ProductionGroupVpc.id
  name   = "production-group-front-security-rules"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    description     = "Incoming Frontend connection"
    security_groups = [aws_security_group.ProductionGroupClientVpnSecurityRules.id]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    description     = "Outgoing Frontend connection"
    security_groups = [aws_security_group.ProductionGroupClientVpnSecurityRules.id]
  }

  tags = {
    Name = "production-group-front-security-rules"
  }
}

resource "aws_security_group" "ProductionGroupPUSecurityRules" {
  vpc_id = aws_vpc.ProductionGroupVpc.id
  name   = "production-group-pu-security-rules"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "TCP"
    description     = "Incoming PU connection"
    security_groups = [aws_security_group.ProductionGroupClientVpnSecurityRules.id]
  }

  egress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "TCP"
    description     = "Outgoing PU connection"
    security_groups = [aws_security_group.ProductionGroupClientVpnSecurityRules.id]
  }

  tags = {
    Name = "production-group-pu-security-rules"
  }
}

resource "aws_security_group" "ProductionGroupBackSecurityRules" {
  vpc_id = aws_vpc.ProductionGroupVpc.id
  name   = "production-group-back-security-rules"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "TCP"
    description     = "Incoming PU connection"
    security_groups = [aws_security_group.ProductionGroupClientVpnSecurityRules.id]
  }

  egress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "TCP"
    description     = "Outgoing PU connection"
    security_groups = [aws_security_group.ProductionGroupClientVpnSecurityRules.id]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    description     = "Incoming Frontend connection"
    security_groups = [aws_security_group.ProductionGroupClientVpnSecurityRules.id]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    description     = "Outgoing Frontend connection"
    security_groups = [aws_security_group.ProductionGroupClientVpnSecurityRules.id]
  }

  tags = {
    Name = "production-group-back-security-rules"
  }
}

resource "aws_security_group" "ProductionGroupClientVpnSecurityRules" {
  vpc_id = aws_vpc.ProductionGroupVpc.id
  name   = "production-group-client-vpn-security-rules"

  ingress {
    from_port   = 443
    protocol    = "UDP"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming VPN connection"
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "production-group-client-vpn-security-rules"
  }
}

resource "aws_security_group" "ProductionGroupPublicSecurityRules" {
  vpc_id = aws_vpc.ProductionGroupVpc.id
  name   = "production-group-public-security-rules"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  tags = {
    Name = "production-group-public-security-rules"
  }
}