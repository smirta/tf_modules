# Create a VPC
resource "aws_vpc" "main-vpc" {
  cidr_block = var.cidr
  availability_zone = var.az
}

# Create subnet
resource "aws_subnet" "main-subnet" {
  cidr_block = var.cidr
  vpc_id = aws_vpc.main-vpc.id
  availability_zone = var.az
}

# Create internet gateway
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id
  availability_zone = var.az
}

# Create routing table
resource "aws_route_table" "main-route" {
  vpc_id = aws_vpc.main-vpc.id
  availability_zone = var.az
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
}

# associate subnet and routing
resource "aws_route_table_association" "main-subnet-assoc" {
  subnet_id      = aws_subnet.main-subnet.id
  route_table_id = aws_route_table.main-route.id
  availability_zone = var.az
}
