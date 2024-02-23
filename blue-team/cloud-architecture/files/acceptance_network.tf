# Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "AcceptanceGroupGateway" { # Creating Internet Gateway
  vpc_id = aws_vpc.AcceptanceGroupVpc.id                   # vpc_id will be generated after we create VPC
  tags = {
    Name = "acceptance-igw"
  }
}

# Route table for Public Subnet's
resource "aws_route_table" "AcceptanceGroupPublicRT" { # Creating RT for Public Subnet
  vpc_id = aws_vpc.AcceptanceGroupVpc.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.AcceptanceGroupGateway.id
  }
  tags = {
    Name = "acceptance-public-crt"
  }
}

# Route table Association with Public Subnet's
resource "aws_route_table_association" "AcceptanceGroupPublicRTassociation" {
  subnet_id      = aws_subnet.AcceptanceGroupPublicSubnet.id
  route_table_id = aws_route_table.AcceptanceGroupPublicRT.id
}


# Route Table for FrontEnd Subnet's
resource "aws_route_table" "AcceptanceFrontEndGroupPrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.AcceptanceGroupVpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.AcceptanceGroupNatGateway.id
  }
  tags = {
    Name = "Acceptance-frontend-private-crt"
  }
}

# Route table Association with Private Subnet's
resource "aws_route_table_association" "AcceptanceGroupFrontEndPrivateRTassociation" {
  subnet_id      = aws_subnet.AcceptanceGroupFrontEndPrivateSubnet.id
  route_table_id = aws_route_table.AcceptanceFrontEndGroupPrivateRT.id
}

# Route Table for Processing Unit Subnet's
resource "aws_route_table" "AcceptancePUGroupPrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.AcceptanceGroupVpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.AcceptanceGroupNatGateway.id
  }
  tags = {
    Name = "Acceptance-pu-private-crt"
  }
}

# Route table Association with Private Subnet's
resource "aws_route_table_association" "AcceptanceGroupPUPrivateRTassociation" {
  subnet_id      = aws_subnet.AcceptanceGroupPUPrivateSubnet.id
  route_table_id = aws_route_table.AcceptancePUGroupPrivateRT.id
}

# Route Table for Backend Subnet's
resource "aws_route_table" "AcceptanceBackendGroupPrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.AcceptanceGroupVpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.AcceptanceGroupNatGateway.id
  }
  tags = {
    Name = "Acceptance-backend-private-crt"
  }
}

# Route table Association with Private Subnet's
resource "aws_route_table_association" "AcceptanceGroupBackendPrivateRTassociation" {
  subnet_id      = aws_subnet.AcceptanceGroupBackEndPrivateSubnet.id
  route_table_id = aws_route_table.AcceptanceBackendGroupPrivateRT.id
}



# NAT Gateway to allow private subnet to connect out the way
resource "aws_eip" "AcceptanceGroupNateIP" {
  vpc = true
}

# Creating the NAT Gateway using subnet_id and allocation_id
resource "aws_nat_gateway" "AcceptanceGroupNatGateway" {
  allocation_id = aws_eip.AcceptanceGroupNateIP.id
  subnet_id     = aws_subnet.AcceptanceGroupPublicSubnet.id

  tags = {
    Name = "VPC Acceptance - NAT"
  }

  # To ensure proper ordering, add Internet Gateway as dependency
  depends_on = [aws_internet_gateway.AcceptanceGroupGateway]
}
