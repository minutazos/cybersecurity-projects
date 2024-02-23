# AWS EC2 Instance holding the front-end software
resource "aws_instance" "TestGroupFrontEndVPC" {
  ami           = var.ami
  instance_type = "t2.micro"

  private_ip             = "10.3.2.129"
  subnet_id              = aws_subnet.TestGroupFrontEndPrivateSubnet.id
  vpc_security_group_ids = ["${aws_security_group.TestGroupFrontEndSecurityRules.id}"]
  key_name               = aws_key_pair.paris-region-key-pair.id

  tags = {
    Name : "Test Front-End VPC"
  }
}

# AWS EC2 Instance holding the front-end software
resource "aws_instance" "TestGroupPUVPC" {
  ami           = var.ami
  instance_type = "t2.micro"

  private_ip             = "10.3.4.128"
  subnet_id              = aws_subnet.TestGroupPUPrivateSubnet.id
  vpc_security_group_ids = ["${aws_security_group.TestGroupPUSecurityRules.id}"]
  key_name               = aws_key_pair.paris-region-key-pair.id

  tags = {
    Name : "Test PU VPC"
  }
}