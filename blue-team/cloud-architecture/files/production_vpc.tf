# Create a VPC with a public and private subnet
resource "aws_vpc" "ProductionGroupVpc" {
  cidr_block           = var.production_vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "production-vpc-1"
  }
}

# Public subnet
resource "aws_subnet" "ProductionGroupPublicSubnet" {
  vpc_id                  = aws_vpc.ProductionGroupVpc.id
  cidr_block              = var.production_public_subnet
  map_public_ip_on_launch = true

  tags = {
    Name = "production-public-subnet-1"
  }
}

# Front private subnet
resource "aws_subnet" "ProductionGroupFrontSubnet" {
  vpc_id            = aws_vpc.ProductionGroupVpc.id
  cidr_block        = var.production_front_subnet
  availability_zone = "eu-west-3a"

  tags = {
    Name = "production-front-subnet-1"
  }
}

# Back private subnet
resource "aws_subnet" "ProductionGroupBackSubnet" {
  vpc_id            = aws_vpc.ProductionGroupVpc.id
  cidr_block        = var.production_back_subnet
  availability_zone = "eu-west-3b"

  tags = {
    Name = "production-back-subnet-1"
  }
}
# Processing Unit subnet
resource "aws_subnet" "ProductionGroupPUSubnet" {
  vpc_id            = aws_vpc.ProductionGroupVpc.id
  cidr_block        = var.production_pu_subnet
  availability_zone = "eu-west-3c"

  tags = {
    Name = "production-pu-subnet-1"
  }
}

# Db subnet
resource "aws_db_subnet_group" "ProductionGroupDatabaseSubnet" {
  name = "production-db-subnet-1"

  subnet_ids = [aws_subnet.ProductionGroupBackSubnet.id, aws_subnet.ProductionGroupPUSubnet.id]

  tags = {
    Name = "production-db-subnet-1"
  }
}