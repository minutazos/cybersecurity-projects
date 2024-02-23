# AWS EC2 Instance holding the front software
resource "aws_instance" "ProductionGroupFrontVPC" {
  ami           = var.ami
  instance_type = "t2.micro"

  private_ip             = "10.2.2.129"
  subnet_id              = aws_subnet.ProductionGroupFrontSubnet.id
  vpc_security_group_ids = ["${aws_security_group.ProductionGroupFrontSecurityRules.id}"]
  key_name               = aws_key_pair.paris-region-key-pair.id

  tags = {
    Name : "Front End EC2"
  }
}

# AWS EC2 Instance holding the computing unit software
resource "aws_instance" "ProductionGroupPUVPC" {
  ami           = var.ami
  instance_type = "t2.micro"

  private_ip             = "10.2.4.103"
  subnet_id              = aws_subnet.ProductionGroupPUSubnet.id
  vpc_security_group_ids = ["${aws_security_group.ProductionGroupBackSecurityRules.id}"]
  key_name               = aws_key_pair.paris-region-key-pair.id

  tags = {
    Name : "Computing unit EC2"
  }
}