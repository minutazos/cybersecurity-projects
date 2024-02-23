resource "aws_security_group_rule" "InternalGroupPostgresCrmAllowed" {
  # this rule is added to the security group defined by `security_group_id`
  # and this id target the `default` security group associated with the created VPC
  security_group_id = aws_security_group.InternalGroupCrmSecurityRules.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432

  # One of ['cidr_blocks', 'ipv6_cidr_blocks', 'self', 'source_security_group_id', 'prefix_list_ids']
  # must be set to create an AWS Security Group Rule
  source_security_group_id = aws_security_group.InternalGroupCrmSecurityRules.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "InternalGroupPostgresAccountingAllowed" {
  # this rule is added to the security group defined by `security_group_id`
  # and this id target the `default` security group associated with the created VPC
  security_group_id = aws_security_group.InternalGroupAccountingSecurityRules.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432

  # One of ['cidr_blocks', 'ipv6_cidr_blocks', 'self', 'source_security_group_id', 'prefix_list_ids']
  # must be set to create an AWS Security Group Rule
  source_security_group_id = aws_security_group.InternalGroupAccountingSecurityRules.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "InternalGroupAccountingSecurityRules" {
  vpc_id = aws_vpc.InternalGroupVpc.id
  name = "internal-group-accounting-security-rules"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    security_groups = [aws_security_group.InternalGroupClientVpnSecurityRules.id]
  }

  tags = {
    Name = "internal-group-accounting-security-rules"
  }
}

resource "aws_security_group" "InternalGroupCrmSecurityRules" {
  vpc_id = aws_vpc.InternalGroupVpc.id
  name = "internal-group-accounting-crm-rules"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    security_groups = [aws_security_group.InternalGroupClientVpnSecurityRules.id]
  }

  tags = {
    Name = "internal-group-crm-security-rules"
  }
}

resource "aws_security_group" "InternalGroupClientVpnSecurityRules" {
  vpc_id = aws_vpc.InternalGroupVpc.id
  name = "internal-group-client-vpn-security-rules"

  ingress {
    from_port = 443
    protocol = "UDP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming VPN connection"
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "internal-group-client-vpn-security-rules"
  }
}