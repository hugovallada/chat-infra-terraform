resource "aws_vpc" "vpc-chat" {
  cidr_block = "10.0.0.0/16"
}

data "aws_availability_zones" "avz" {}

resource "aws_subnet" "vpc-chat-public-subnet" {
  vpc_id            = aws_vpc.vpc-chat.id
  count             = length(var.public-subnets)
  cidr_block        = var.public-subnets[count.index]
  availability_zone = data.aws_availability_zones.avz.names[count.index]
}

resource "aws_subnet" "vpc-chat-private-subnet" {
  vpc_id            = aws_vpc.vpc-chat.id
  count             = length(var.public-subnets)
  cidr_block        = var.private-subnets[count.index]
  availability_zone = data.aws_availability_zones.avz.names[count.index]
}

resource "aws_internet_gateway" "chat-gw" {
  vpc_id = aws_vpc.vpc-chat.id
}

resource "aws_eip" "chat-eip" {
  count = length(var.private-subnets)
  vpc   = true
}

resource "aws_nat_gateway" "chat-nat-gw" {
  count         = length(var.private-subnets)
  subnet_id     = aws_subnet.vpc-chat-private-subnet[count.index].id
  allocation_id = aws_eip.chat-eip[count.index].id
}

