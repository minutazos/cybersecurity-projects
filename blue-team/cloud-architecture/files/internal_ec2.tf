# AWS EC2 Instance holding the accounting software
resource "aws_instance" "InternalGroupAccountingVPC" {
  ami           = var.ami
  instance_type = "t2.micro"

  private_ip             = "10.0.2.129"
  subnet_id              = aws_subnet.InternalGroupPrivateSubnet.id
  vpc_security_group_ids = ["${aws_security_group.InternalGroupAccountingSecurityRules.id}"]
  key_name               = aws_key_pair.paris-region-key-pair.id

  tags = {
    Name : "Internal Accounting EC2"
  }
}

# AWS EC2 Instance holding the CRM software
resource "aws_instance" "InternalGroupCrmVPC" {
  ami           = var.ami
  instance_type = "t2.micro"

  private_ip             = "10.0.2.128"
  subnet_id              = aws_subnet.InternalGroupPrivateSubnet.id
  vpc_security_group_ids = ["${aws_security_group.InternalGroupCrmSecurityRules.id}"]
  key_name               = aws_key_pair.paris-region-key-pair.id

  tags = {
    Name : "Internal CRM EC2"
  }
}