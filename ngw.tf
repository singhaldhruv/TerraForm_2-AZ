resource "aws_eip" "nat_eip" {
  count = length(var.cidr_private_subnet)
  domain = "vpc"
}


resource "aws_nat_gateway" "nat-gw-dhruv" {
  count      = length(var.cidr_private_subnet)
  depends_on = [aws_eip.nat_eip]
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.private_subnet_us-west-2[count.index].id

  tags = {
    Name = "gw NAT"
  }


  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  # depends_on = [aws_internet_gateway.example]
}

/* resource "aws_nat_gateway" "nat_gateway" {
  count      = length(var.cidr_private_subnet)
  depends_on = [aws_eip.nat_eip]
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id = aws_subnet.aws_jhooq_private_subnets[count.index].id
  tags = {
    "Name" = "Private NAT GW: For Jhooq EU Central Project "
  }
} */