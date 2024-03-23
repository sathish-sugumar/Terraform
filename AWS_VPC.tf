
#creating VPC and public subnet enabling the internet gate to vpc and public subnet through RT

resource "aws_vpc" "MyVPC" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "MyVPC"
  }
}

#creating one subnet
resource "aws_subnet" "Publicsubnet" {
  vpc_id     = aws_vpc.MyVPC.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "Public subnet"
  }
}

# creating internet gatway

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.MyVPC.id

  tags = {
    Name = "IGW"
  }
}


# creating public Route table

resource "aws_route_table" "PUblicRT" {
  vpc_id = aws_vpc.MyVPC.id

  route {
    cidr_block = "0.0.0.0/16"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "PUblicRT"
  }
}

# associating route table to public subnet

resource "aws_route_table_association" "PUblicRT" {
  subnet_id      = aws_subnet.Publicsubnet.id
  route_table_id = aws_route_table.PUblicRT.id
}
