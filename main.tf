// Define the VPC resource
resource "aws_vpc" "vpc_test" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    var.tags,
    map(
      "Name", "Testing-${var.deployment_name}-vpc-${terraform.workspace}"
    )
  )
}

//Internet Gateway Creation
resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.vpc_test.id

  tags = merge(
    var.tags,
    map(
      "Name", "Testing-${var.deployment_name}-internet-${terraform.workspace}"
    )
  )
}

//Public Subnet
resource "aws_subnet" "public_subnet_testing_1" {
  vpc_id                  = aws_vpc.vpc_test.id
  cidr_block              = var.public_subnet_cidr[0]
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  depends_on              = [aws_internet_gateway.internet]
  
  tags = merge(
      var.tags,
      map(
        "Name", "Testing-${var.deployment_name}-pub_sub1-${terraform.workspace}"
    )
  )
}

//Public Subnet #2
resource "aws_subnet" "public_subnet_testing_2" {
  vpc_id                  = aws_vpc.vpc_test.id
  cidr_block              = var.public_subnet_cidr[1]
  availability_zone       = var.azs[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  depends_on              = [aws_internet_gateway.internet]
  
  tags = merge(
      var.tags,
      map(
        "Name", "Testing-${var.deployment_name}-pub_sub2-${terraform.workspace}"
    )
  )
}

//Routing Table for access to the Internet Gateway
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet.id
  }

  tags = merge(
      var.tags,
      map(
        "Name", "Testing-${var.deployment_name}-routing-table-${terraform.workspace}"
    )
  )
}

resource "aws_route_table_association" "public_subnet_testing_1" {
  subnet_id = aws_subnet.public_subnet_testing_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_testing_2" {
  subnet_id = aws_subnet.public_subnet_testing_2.id
  route_table_id = aws_route_table.public.id
}