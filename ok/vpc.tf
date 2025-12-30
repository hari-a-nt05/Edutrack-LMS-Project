data "aws_availability_zones" "available" {
  state = "available"
}

# VPC
resource "aws_vpc" "lms_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "lms-vpc"
  }
}

# Public Subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.lms_vpc.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "lms-public-subnet-1"
  }
}

# Public Subnet 2 (DIFFERENT AZ)
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.lms_vpc.id
  cidr_block              = "10.0.12.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "lms-public-subnet-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lms_vpc.id

  tags = {
    Name = "lms-igw"
  }
}


# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.lms_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "lms-public-rt"
  }
}


# Route Table Association
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}
