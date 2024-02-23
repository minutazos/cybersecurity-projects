# Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "InternalGroupGateway" { # Creating Internet Gateway
  vpc_id = aws_vpc.InternalGroupVpc.id                   # vpc_id will be generated after we create VPC
  tags = {
    Name = "internal-igw"
  }
}

# Route table for Public Subnet's
resource "aws_route_table" "InternalGroupPublicRT" { # Creating RT for Public Subnet
  vpc_id = aws_vpc.InternalGroupVpc.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.InternalGroupGateway.id
  }
  tags = {
    Name = "internal-public-crt"
  }
}

# Route table for Private Subnet's
resource "aws_route_table" "InternalGroupPrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.InternalGroupVpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.InternalGroupNatGateway.id
  }
  tags = {
    Name = "internal-private-crt"
  }
}

# Route table Association with Public Subnet's
resource "aws_route_table_association" "InternalGroupPublicRTassociation" {
  subnet_id      = aws_subnet.InternalGroupPublicSubnet.id
  route_table_id = aws_route_table.InternalGroupPublicRT.id
}

# Route table Association with Private Subnet's
resource "aws_route_table_association" "InternalGroupPrivateRTassociation" {
  subnet_id      = aws_subnet.InternalGroupPrivateSubnet.id
  route_table_id = aws_route_table.InternalGroupPrivateRT.id
}

# NAT Gateway to allow private subnet to connect out the way
resource "aws_eip" "InternalGroupNateIP" {
  vpc = true
}

# Creating the NAT Gateway using subnet_id and allocation_id
resource "aws_nat_gateway" "InternalGroupNatGateway" {
  allocation_id = aws_eip.InternalGroupNateIP.id
  subnet_id     = aws_subnet.InternalGroupPublicSubnet.id

  tags = {
    Name = "VPC Internal - NAT"
  }

  # To ensure proper ordering, add Internet Gateway as dependency
  depends_on = [aws_internet_gateway.InternalGroupGateway]
}
