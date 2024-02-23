# Create The Test VPC
resource "aws_vpc" "TestGroupVpc" { # Creating VPC here
  cidr_block       = var.test_vpc_cidr  # Defining the CIDR block use 10.0.0.0/24 for demo
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Test-vpc-1"
  }
}

# Create a Test Public Subnets.
resource "aws_subnet" "TestGroupPublicSubnet" { # Creating Public Subnets
  vpc_id                  = aws_vpc.TestGroupVpc.id
  map_public_ip_on_launch = "true"             # This is what makes it a public subnet
  cidr_block              = var.test_public_subnet # CIDR block of public subnets
  tags = {
    Name = "Test-subnet-public-1"
  }
}

# Create a Db Subnet
resource "aws_db_subnet_group" "TestGroupDatabaseSubnetGroup" {
  name       = "test-db-subnet-1"

  subnet_ids = [aws_subnet.TestGroupPUPrivateSubnet.id, aws_subnet.TestGroupBackEndPrivateSubnet.id]

  tags = {
    Name = "Test-db-subnet-1"
  }
}

# Create a Front-End Private Subnet
resource "aws_subnet" "TestGroupFrontEndPrivateSubnet" {
  vpc_id     = aws_vpc.TestGroupVpc.id
  cidr_block = var.test_private_subnet_front # CIDR block of private subnets
  availability_zone = "eu-west-3a"

  tags = {
    Name = "Test-frontend-subnet-private-1"
  }
}

# Create a Back Private Subnet
resource "aws_subnet" "TestGroupBackEndPrivateSubnet" {
  vpc_id     = aws_vpc.TestGroupVpc.id
  cidr_block = var.test_private_subnet_back # CIDR block of private subnets
  availability_zone = "eu-west-3b"

  tags = {
    Name = "Test-backend-subnet-private-1"
  }
}

# Create a Proccessing Unit  Private Subnet
resource "aws_subnet" "TestGroupPUPrivateSubnet" {
  vpc_id     = aws_vpc.TestGroupVpc.id
  cidr_block = var.test_private_subnet_pu # CIDR block of private subnets
  availability_zone = "eu-west-3c"

  tags = {
    Name = "Test-pu-subnet-private-1"
  }
}
