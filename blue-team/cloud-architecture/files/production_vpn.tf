resource "aws_ec2_client_vpn_endpoint" "ProductionGroupClientVpnEndpoint" {
  description            = "Production-clientvpn-endpoint"
  server_certificate_arn = aws_acm_certificate.ProductionGroupACMCertificateServer.arn
  client_cidr_block      = "10.29.0.0/16"
  vpc_id                 = aws_vpc.ProductionGroupVpc.id
  security_group_ids     = [aws_security_group.ProductionGroupClientVpnSecurityRules.id]

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.ProductionGroupACMCertificateClient.arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.ProductionGroupCloudWatchLogGroup.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.ProductionGroupCloudWatchLogStream.name
  }
}

resource "aws_ec2_client_vpn_network_association" "ProductionGroupVpnNetworkAssociation" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.ProductionGroupClientVpnEndpoint.id
  subnet_id              = aws_subnet.ProductionGroupFrontSubnet.id

  lifecycle {
    // The issue why we are ignoring changes is that on every change
    // terraform screws up most of the vpn assosciations
    // see: https://github.com/hashicorp/terraform-provider-aws/issues/14717
    ignore_changes = [subnet_id]
  }
}

resource "aws_ec2_client_vpn_authorization_rule" "ProductionGroupVpnAuthorizationRule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.ProductionGroupClientVpnEndpoint.id
  target_network_cidr    = aws_subnet.ProductionGroupFrontSubnet.cidr_block
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_route" "ProductionGroupVpnRoute" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.ProductionGroupClientVpnEndpoint.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.ProductionGroupVpnNetworkAssociation.subnet_id
}