#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "socks-shop-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = tomap({
    "Name"                                      = "socks-shop-eks-node",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  })
}

resource "aws_subnet" "socks-shop" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.socks-shop-vpc.id

  tags = tomap({
    "Name"                                      = "socks-shop-eks-node",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  })
}

resource "aws_internet_gateway" "socks-shop-igw" {
  vpc_id = aws_vpc.socks-shop-vpc.id

  tags = {
    Name = "socks-shop-igw"
  }
}

resource "aws_route_table" "socks-shop" {
  vpc_id = aws_vpc.socks-shop-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.socks-shop-igw.id
  }
}

resource "aws_route_table_association" "socks-shop" {
  count = 2

  subnet_id      = aws_subnet.socks-shop[count.index].id
  route_table_id = aws_route_table.socks-shop.id
}

resource "aws_default_security_group" "socks-shop-sg" {
  vpc_id = aws_vpc.socks-shop-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}  