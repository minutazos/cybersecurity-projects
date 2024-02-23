# Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "TestGroupGateway" { # Creating Internet Gateway
  vpc_id = aws_vpc.TestGroupVpc.id                   # vpc_id will be generated after we create VPC
  tags = {
    Name = "Test-igw"
  }
}

# Route table for Public Subnet's
resource "aws_route_table" "TestGroupPublicRT" { # Creating RT for Public Subnet
  vpc_id = aws_vpc.TestGroupVpc.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.TestGroupGateway.id
  }
  tags = {
    Name = "Test-public-crt"
  }
}

# Route table Association with Public Subnet's
resource "aws_route_table_association" "TestGroupPublicRTassociation" {
  subnet_id      = aws_subnet.TestGroupPublicSubnet.id
  route_table_id = aws_route_table.TestGroupPublicRT.id
}


# Route Table for FrontEnd Subnet's
resource "aws_route_table" "TestFrontEndGroupPrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.TestGroupVpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.TestGroupNatGateway.id
  }
  tags = {
    Name = "Test-frontend-private-crt"
  }
}

# Route table Association with Private Subnet's
resource "aws_route_table_association" "TestGroupFrontEndPrivateRTassociation" {
  subnet_id      = aws_subnet.TestGroupFrontEndPrivateSubnet.id
  route_table_id = aws_route_table.TestFrontEndGroupPrivateRT.id
}

# Route Table for Processing Unit Subnet's
resource "aws_route_table" "TestPUGroupPrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.TestGroupVpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.TestGroupNatGateway.id
  }
  tags = {
    Name = "Test-pu-private-crt"
  }
}

# Route table Association with Private Subnet's
resource "aws_route_table_association" "TestGroupPUPrivateRTassociation" {
  subnet_id      = aws_subnet.TestGroupPUPrivateSubnet.id
  route_table_id = aws_route_table.TestPUGroupPrivateRT.id
}

# Route Table for Backend Subnet's
resource "aws_route_table" "TestBackendGroupPrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.TestGroupVpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.TestGroupNatGateway.id
  }
  tags = {
    Name = "Test-backend-private-crt"
  }
}

# Route table Association with Private Subnet's
resource "aws_route_table_association" "TestGroupBackendPrivateRTassociation" {
  subnet_id      = aws_subnet.TestGroupBackEndPrivateSubnet.id
  route_table_id = aws_route_table.TestBackendGroupPrivateRT.id
}



# NAT Gateway to allow private subnet to connect out the way
resource "aws_eip" "TestGroupNateIP" {
  vpc = true
}

# Creating the NAT Gateway using subnet_id and allocation_id
resource "aws_nat_gateway" "TestGroupNatGateway" {
  allocation_id = aws_eip.TestGroupNateIP.id
  subnet_id     = aws_subnet.TestGroupPublicSubnet.id

  tags = {
    Name = "VPC Test - NAT"
  }

  # To ensure proper ordering, add Internet Gateway as dependency
  depends_on = [aws_internet_gateway.TestGroupGateway]
}
