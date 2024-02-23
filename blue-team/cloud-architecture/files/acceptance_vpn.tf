resource "aws_ec2_client_vpn_endpoint" "AcceptanceGroupClientVpnEndpoint" {
  description            = "Acceptance-clientvpn-endpoint"
  server_certificate_arn = aws_acm_certificate.AcceptanceGroupACMCertificateServer.arn
  client_cidr_block      = "10.28.0.0/16"
  vpc_id                 = aws_vpc.AcceptanceGroupVpc.id
  security_group_ids     = [aws_security_group.AcceptanceGroupClientVpnSecurityRules.id]

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.AcceptanceGroupACMCertificateClient.arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.AcceptanceGroupCloudWatchLogGroup.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.AcceptanceGroupCloudWatchLogStream.name
  }
}

resource "aws_ec2_client_vpn_network_association" "AcceptanceGroupVpnNetworkAssociation" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.AcceptanceGroupClientVpnEndpoint.id
  subnet_id              = aws_subnet.AcceptanceGroupFrontEndPrivateSubnet.id
  security_groups        = [aws_security_group.AcceptanceGroupClientVpnSecurityRules.id]

  lifecycle {
    ignore_changes = [subnet_id]
  }
}

resource "aws_ec2_client_vpn_authorization_rule" "AcceptanceGroupVpnAuthorizationRule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.AcceptanceGroupClientVpnEndpoint.id
  target_network_cidr    = aws_subnet.AcceptanceGroupFrontEndPrivateSubnet.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_route" "AcceptanceGroupVpnRoute" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.AcceptanceGroupClientVpnEndpoint.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.AcceptanceGroupVpnNetworkAssociation.subnet_id
}