# Create The Acceptance VPC
resource "aws_vpc" "AcceptanceGroupVpc" { # Creating VPC here
  cidr_block       = var.acceptance_vpc_cidr  # Defining the CIDR block use 10.0.0.0/24 for demo
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Acceptance-vpc-1"
  }
}

# Create a Acceptance Public Subnets.
resource "aws_subnet" "AcceptanceGroupPublicSubnet" { # Creating Public Subnets
  vpc_id                  = aws_vpc.AcceptanceGroupVpc.id
  map_public_ip_on_launch = "true"             # This is what makes it a public subnet
  cidr_block              = var.acceptance_public_subnet # CIDR block of public subnets
  tags = {
    Name = "Acceptance-subnet-public-1"
  }
}

# Create a Db Subnet
resource "aws_db_subnet_group" "AcceptanceGroupDatabaseSubnetGroup" {
  name       = "acceptance-db-subnet-1"

  subnet_ids = [aws_subnet.AcceptanceGroupPUPrivateSubnet.id, aws_subnet.AcceptanceGroupBackEndPrivateSubnet.id]

  tags = {
    Name = "Acceptance-db-subnet-1"
  }
}

# Create a Front-End Private Subnet
resource "aws_subnet" "AcceptanceGroupFrontEndPrivateSubnet" {
  vpc_id     = aws_vpc.AcceptanceGroupVpc.id
  cidr_block = var.acceptance_private_subnet_front # CIDR block of private subnets
  availability_zone = "eu-west-3a"

  tags = {
    Name = "Acceptance-frontend-subnet-private-1"
  }
}

# Create a Back Private Subnet
resource "aws_subnet" "AcceptanceGroupBackEndPrivateSubnet" {
  vpc_id     = aws_vpc.AcceptanceGroupVpc.id
  cidr_block = var.acceptance_private_subnet_back # CIDR block of private subnets
  availability_zone = "eu-west-3b"

  tags = {
    Name = "Acceptance-backend-subnet-private-1"
  }
}

# Create a Proccessing Unit  Private Subnet
resource "aws_subnet" "AcceptanceGroupPUPrivateSubnet" {
  vpc_id     = aws_vpc.AcceptanceGroupVpc.id
  cidr_block = var.acceptance_private_subnet_pu # CIDR block of private subnets
  availability_zone = "eu-west-3c"

  tags = {
    Name = "Acceptance-pu-subnet-private-1"
  }
}
