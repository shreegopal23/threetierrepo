# VPC Resource
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
#   enable_dns_support = yes
#   enable_dns_hostnames = yes
  tags = {
    "name" = "${var.app_name}-vpc"
  }
}
#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "name" = "${var.app_name}-igw"
  }
}
# public Subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "name" = "${var.app_name}-publicsubnet-${count.index}"
  }
}
# private subnet
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "name" = "${var.app_name}-privatesubnet-${count.index}"
  }
}
# public Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
# route table association
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id = aws_subnet.public[count.index].id 
  route_table_id = aws_route_table.public.id
}

data "aws_availability_zones" "available" {
  
}