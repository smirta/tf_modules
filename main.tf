terraform {
  backend "remote" {
    organization = "technophilch"

    workspaces {
      name = "simuawsplayground"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "us-west-2"
}

# Get the AWS Ubuntu image
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Create a VPC
resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create subnet
resource "aws_subnet" "main-subnet" {
  cidr_block = "10.0.0.0/16"
  vpc_id = aws_vpc.main-vpc.id
}

# Create internet gateway
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id
}

# Create routing table
resource "aws_route_table" "main-route" {
  vpc_id = aws_vpc.main-vpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
}

# associate subnet and routing
resource "aws_route_table_association" "main-subnet-assoc" {
  subnet_id      = aws_subnet.main-subnet.id
  route_table_id = aws_route_table.main-route.id
}

# Public key for instance access
resource "aws_key_pair" "admin" {
  key_name = "admin" 
  public_key = file(".ssh/id_rsa.pub")
}
