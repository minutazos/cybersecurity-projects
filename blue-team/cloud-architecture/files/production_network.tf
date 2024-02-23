# Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "ProductionGroupGateway" { # Creating Internet Gateway
  vpc_id = aws_vpc.ProductionGroupVpc.id                   # vpc_id will be generated after we create VPC
  tags = {
    Name = "production-igw"
  }
}

resource "aws_route_table" "ProductionGroupPublicRT" { # Creating RT for Public Subnet
  vpc_id = aws_vpc.ProductionGroupVpc.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.ProductionGroupGateway.id
  }
  tags = {
    Name = "production-public-crt"
  }
}

# NAT Gateway to allow private subnet to connect out the way
resource "aws_eip" "ProductionGroupNatIP" {
  vpc = true
}

# Creating the NAT Gateway using subnet_id and allocation_id
resource "aws_nat_gateway" "ProductionGroupNatGateway" {
  allocation_id = aws_eip.ProductionGroupNatIP.id
  subnet_id     = aws_subnet.ProductionGroupPublicSubnet.id

  tags = {
    Name = "VPC Production NAT Gateway"
  }

  # To ensure proper ordering, add Internet Gateway as dependency
  depends_on = [aws_internet_gateway.ProductionGroupGateway]
}

# Route table Association with Public Subnet's
resource "aws_route_table_association" "ProductionGroupPublicRTassociation" {
  subnet_id      = aws_subnet.ProductionGroupPublicSubnet.id
  route_table_id = aws_route_table.ProductionGroupPublicRT.id
}

# Route table for Front Subnet
resource "aws_route_table" "ProductionGroupFrontRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.ProductionGroupVpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.ProductionGroupNatGateway.id
  }
  tags = {
    Name = "production-front-crt"
  }
}

# Route table Association with Front Subnet's
resource "aws_route_table_association" "ProductionGroupFrontRTassociation" {
  subnet_id      = aws_subnet.ProductionGroupFrontSubnet.id
  route_table_id = aws_route_table.ProductionGroupFrontRT.id
}

# Route table for Back Subnet
resource "aws_route_table" "ProductionGroupBackRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.ProductionGroupVpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.ProductionGroupNatGateway.id
  }
  tags = {
    Name = "production-back-crt"
  }
}

# Route table Association with Back Subnet's
resource "aws_route_table_association" "ProductionGroupBackRTassociation" {
  subnet_id      = aws_subnet.ProductionGroupBackSubnet.id
  route_table_id = aws_route_table.ProductionGroupBackRT.id
}