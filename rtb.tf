resource "aws_route_table" "us-west-rtb-public" {
  vpc_id = aws_vpc.vpc-us-west-2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.us-igw.id
  }

  /* route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway..id
  } */

  tags = {
    Name = "public-rtb"
  }
}


resource "aws_route_table" "us-west-rtb-private" {
  count      = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.vpc-us-west-2.id
  depends_on = [aws_nat_gateway.nat-gw-dhruv]

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-dhruv[count.index].id
  }

  /* route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway..id
  } */

  tags = {
    Name = "private-rtb"
  }
}


/* resource "aws_route_table" "jhooq_private_route_table" {
  count      = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.vpc-jhooq-eu-central-1.id
  depends_on = [aws_nat_gateway.nat_gateway]
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }
  tags = {
    Name = "RT Private: For Jhooq EU Central Project "
  }
} */


  