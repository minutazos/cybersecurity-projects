# AWS EC2 Instance holding the front-end software
resource "aws_instance" "AcceptanceGroupFrontEndVPC" {
  ami           = var.ami
  instance_type = "t2.micro"

  private_ip             = "10.1.2.129"
  subnet_id              = aws_subnet.AcceptanceGroupFrontEndPrivateSubnet.id
  vpc_security_group_ids = ["${aws_security_group.AcceptanceGroupFrontEndSecurityRules.id}"]
  key_name               = aws_key_pair.paris-region-key-pair.id

  tags = {
    Name : "Acceptance Front-End VPC"
  }
}

# AWS EC2 Instance holding the front-end software
resource "aws_instance" "AcceptanceGroupPUVPC" {
  ami           = var.ami
  instance_type = "t2.micro"

  private_ip             = "10.1.4.128"
  subnet_id              = aws_subnet.AcceptanceGroupPUPrivateSubnet.id
  vpc_security_group_ids = ["${aws_security_group.AcceptanceGroupPUSecurityRules.id}"]
  key_name               = aws_key_pair.paris-region-key-pair.id

  tags = {
    Name : "Acceptance PU VPC"
  }
}