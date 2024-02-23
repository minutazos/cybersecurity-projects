# Create The VPC
resource "aws_vpc" "InternalGroupVpc" { # Creating VPC here
  cidr_block       = var.internal_vpc_cidr  # Defining the CIDR block use 10.0.0.0/24 for demo
  instance_tenancy = "default"

  tags = {
    Name = "internal-vpc-1"
  }
}

# Create a Public Subnets.
resource "aws_subnet" "InternalGroupPublicSubnet" { # Creating Public Subnets
  vpc_id                  = aws_vpc.InternalGroupVpc.id
  map_public_ip_on_launch = "true"             # This is what makes it a public subnet
  cidr_block              = var.internal_public_subnet # CIDR block of public subnets
  tags = {
    Name = "internal-subnet-public-1"
  }
}

# Create a Private Subnet
resource "aws_subnet" "InternalGroupPrivateSubnet" {
  vpc_id     = aws_vpc.InternalGroupVpc.id
  cidr_block = var.internal_private_subnet # CIDR block of private subnets
  availability_zone = "eu-west-3a"

  tags = {
    Name = "internal-subnet-private-1"
  }
}

# Create a Private Subnet
resource "aws_subnet" "InternalGroupPrivateSubnet1" {
  vpc_id     = aws_vpc.InternalGroupVpc.id
  cidr_block = var.internal_private_subnet_1 # CIDR block of private subnets
  availability_zone = "eu-west-3b"
  
  tags = {
    Name = "internal-subnet-private-2"
  }
}

# Create a Db Subnet
resource "aws_db_subnet_group" "InternalGroupDatabaseSubnetGroup" {
  name       = "internal-db-subnet-1"

  subnet_ids = [aws_subnet.InternalGroupPrivateSubnet.id, aws_subnet.InternalGroupPrivateSubnet1.id]

  tags = {
    Name = "internal-db-subnet-1"
  }
}