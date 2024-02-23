resource "aws_ec2_client_vpn_endpoint" "TestGroupClientVpnEndpoint" {
  description            = "Test-clientvpn-endpoint"
  server_certificate_arn = aws_acm_certificate.TestGroupACMCertificateServer.arn
  client_cidr_block      = "10.30.0.0/16"
  vpc_id                 = aws_vpc.TestGroupVpc.id
  security_group_ids     = [aws_security_group.TestGroupClientVpnSecurityRules.id]

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.TestGroupACMCertificateClient.arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.TestGroupCloudWatchLogGroup.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.TestGroupCloudWatchLogStream.name
  }
}

resource "aws_ec2_client_vpn_network_association" "TestGroupVpnNetworkAssociation" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.TestGroupClientVpnEndpoint.id
  subnet_id              = aws_subnet.TestGroupPublicSubnet.id
  security_groups        = [aws_security_group.TestGroupClientVpnSecurityRules.id]

  lifecycle {
    ignore_changes = [subnet_id]
  }
}

resource "aws_ec2_client_vpn_authorization_rule" "TestGroupVpnAuthorizationRule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.TestGroupClientVpnEndpoint.id
  target_network_cidr    = aws_subnet.TestGroupPublicSubnet.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_route" "TestGroupVpnRoute" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.TestGroupClientVpnEndpoint.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.TestGroupVpnNetworkAssociation.subnet_id
}