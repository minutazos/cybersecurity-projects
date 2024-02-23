resource "aws_acm_certificate" "ProductionGroupACMCertificateClient" {
  private_key       = file("./vpn/client1.vpn.tld.key")
  certificate_body  = file("./vpn/client1.vpn.tld.crt")
  certificate_chain = file("./vpn/ca.crt")
}

resource "aws_acm_certificate" "ProductionGroupACMCertificateServer" {
  private_key       = file("./vpn/server.key")
  certificate_body  = file("./vpn/server.crt")
  certificate_chain = file("./vpn/ca.crt")
}