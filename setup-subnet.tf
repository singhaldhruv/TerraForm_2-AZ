resource "aws_subnet" "public_subnet_us-west-2" {
  vpc_id     = aws_vpc.vpc-us-west-2.id
  count = length(var.cidr_public_subnet)
  cidr_block = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.us_availability_zone, count.index)

  tags = {
    Name = "Public_Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet_us-west-2" {
  vpc_id     = aws_vpc.vpc-us-west-2.id
  count = length(var.cidr_private_subnet)
  cidr_block = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.us_availability_zone, count.index)

  tags = {
    Name = "Private_Subnet ${count.index + 1}"
  }
}


# Setup public subnet
/* resource "aws_subnet" "aws_public_subnets" {
  count      = length(var.cidr_public_subnet)
  vpc_id     = aws_vpc.vpc-ap-south-1.id
  cidr_block = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.ap_availability_zone, count.index)

  tags = {
    Name = "Subnet-Public : Public Subnet ${count.index + 1}"
  }
}

# Setup private subnet
resource "aws_subnet" "aws_private_subnets" {
  count      = length(var.cidr_private_subnet)
  vpc_id     = aws_vpc.vpc-ap-south-1.id
  cidr_block = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.ap_availability_zone, count.index)

  tags = {
    Name = "Subnet-Private : Private Subnet ${count.index + 1}"
  }
} */