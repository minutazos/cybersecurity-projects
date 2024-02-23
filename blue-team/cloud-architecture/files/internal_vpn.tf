resource "aws_ec2_client_vpn_endpoint" "InternalGroupClientVpnEndpoint" {
  description            = "internal-clientvpn-endpoint"
  server_certificate_arn = aws_acm_certificate.InternalGroupACMCertificateServer.arn
  client_cidr_block      = "10.27.0.0/16"
  vpc_id                 = aws_vpc.InternalGroupVpc.id
  security_group_ids     = [aws_security_group.InternalGroupClientVpnSecurityRules.id]

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.InternalGroupACMCertificateClient.arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.InternalGroupCloudWatchLogGroup.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.InternalGroupCloudWatchLogStream.name
  }
}

resource "aws_ec2_client_vpn_network_association" "InternalGroupVpnNetworkAssociation" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.InternalGroupClientVpnEndpoint.id
  subnet_id              = aws_subnet.InternalGroupPrivateSubnet.id
  security_groups        = [aws_security_group.InternalGroupClientVpnSecurityRules.id]

  lifecycle {
    // The issue why we are ignoring changes is that on every change
    // terraform screws up most of the vpn assosciations
    // see: https://github.com/hashicorp/terraform-provider-aws/issues/14717
    ignore_changes = [subnet_id]
  }
}

resource "aws_ec2_client_vpn_authorization_rule" "InternalGroupVpnAuthorizationRule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.InternalGroupClientVpnEndpoint.id
  target_network_cidr    = aws_subnet.InternalGroupPrivateSubnet.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_route" "InternalGroupVpnRoute" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.InternalGroupClientVpnEndpoint.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.InternalGroupVpnNetworkAssociation.subnet_id
}