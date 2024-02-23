resource "aws_security_group" "AcceptanceGroupFrontEndSecurityRules" {
  vpc_id = aws_vpc.AcceptanceGroupVpc.id
  name = "Acceptance-group-frontend-security-rules"

  ingress {
    from_port = 80
    protocol = "TCP"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming front-end connection"
  }
  
  ingress {
    from_port = 443
    protocol = "UDP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming VPN connection"
  }

  egress {
    from_port = 443
    protocol = "UDP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Exit VPN connection"
  }

  egress {
    from_port = 80
    protocol = "TCP"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "Exit front-end connection"
  }

  tags = {
    Name = "Acceptance-group-frontend-security-rules"
  }
}

resource "aws_security_group" "AcceptanceGroupBackendSecurityRules" {
  vpc_id = aws_vpc.AcceptanceGroupVpc.id
  name = "Acceptance-group-backend-security-rules"

  ingress {
    from_port = 8080
    protocol = "TCP"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming PU connection"
  }

  ingress {
    from_port = 80
    protocol = "TCP"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming FrontEnd connection"
  }

  ingress {
    from_port = 443
    protocol = "UDP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming VPN connection"
  }

  egress {
    from_port = 443
    protocol = "UDP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Exit VPN connection"
  }

  egress {
    from_port = 8080
    protocol = "TCP"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
    description = "Exit backend connection to PU"
  }

  egress {
    from_port = 80
    protocol = "TCP"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "Exit backend connection to FrontEnd"
  }

  tags = {
    Name = "Acceptance-group-backend-security-rules"
  }
}
resource "aws_security_group" "AcceptanceGroupPUSecurityRules" {
  vpc_id = aws_vpc.AcceptanceGroupVpc.id
  name = "Acceptance-group-pu-security-rules"

  ingress {
    from_port = 8080
    protocol = "TCP"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming PU connection"
  }

  ingress {
    from_port = 443
    protocol = "UDP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming VPN connection"
  }

  egress {
    from_port = 443
    protocol = "UDP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Exit VPN connection"
  }

  egress {
    from_port = 8080
    protocol = "TCP"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
    description = "Exit PU connection"
  }

  tags = {
    Name = "Acceptance-group-pu-security-rules"
  }
}

resource "aws_security_group_rule" "AcceptanceGroupPostgresBackAllowed" {
  # this rule is added to the security group defined by `security_group_id`
  # and this id target the `default` security group associated with the created VPC
  security_group_id = aws_security_group.AcceptanceGroupBackendSecurityRules.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432

  # One of ['cidr_blocks', 'ipv6_cidr_blocks', 'self', 'source_security_group_id', 'prefix_list_ids']
  # must be set to create an AWS Security Group Rule
  source_security_group_id = aws_security_group.AcceptanceGroupBackendSecurityRules.id

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "AcceptanceGroupClientVpnSecurityRules" {
  vpc_id = aws_vpc.AcceptanceGroupVpc.id
  name = "Acceptance-group-client-vpn-security-rules"

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
    Name = "Acceptance-group-client-vpn-security-rules"
  }
}