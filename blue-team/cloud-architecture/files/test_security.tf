resource "aws_security_group" "TestGroupFrontEndSecurityRules" {
  vpc_id = aws_vpc.TestGroupVpc.id
  name = "Test-group-frontend-security-rules"

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
    Name = "Test-group-frontend-security-rules"
  }
}

resource "aws_security_group" "TestGroupBackendSecurityRules" {
  vpc_id = aws_vpc.TestGroupVpc.id
  name = "Test-group-backend-security-rules"

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
    Name = "Test-group-backend-security-rules"
  }
}
resource "aws_security_group" "TestGroupPUSecurityRules" {
  vpc_id = aws_vpc.TestGroupVpc.id
  name = "Test-group-pu-security-rules"

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
    Name = "Test-group-pu-security-rules"
  }
}

resource "aws_security_group_rule" "TestGroupPostgresBackAllowed" {
  # this rule is added to the security group defined by `security_group_id`
  # and this id target the `default` security group associated with the created VPC
  security_group_id = aws_security_group.TestGroupBackendSecurityRules.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432

  # One of ['cidr_blocks', 'ipv6_cidr_blocks', 'self', 'source_security_group_id', 'prefix_list_ids']
  # must be set to create an AWS Security Group Rule
  source_security_group_id = aws_security_group.TestGroupBackendSecurityRules.id

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "TestGroupClientVpnSecurityRules" {
  vpc_id = aws_vpc.TestGroupVpc.id
  name = "Test-group-client-vpn-security-rules"

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
    Name = "Test-group-client-vpn-security-rules"
  }
}