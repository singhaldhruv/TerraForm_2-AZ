resource "aws_route_table_association" "public_subnet_asso" {
    count = length(var.cidr_public_subnet)
    depends_on = [aws_subnet.public_subnet_us-west-2, aws_route_table.us-west-rtb-public  ]
  subnet_id      = element(aws_subnet.public_subnet_us-west-2[*].id, count.index)
  route_table_id = aws_route_table.us-west-rtb-public.id
}

/* resource "aws_route_table_association" "public_subnet_asso" {
  count = length(var.cidr_public_subnet)
  depends_on = [aws_subnet.aws_jhooq_public_subnets, aws_route_table.jhooq_public_route_table]
  subnet_id      = element(aws_subnet.aws_jhooq_public_subnets[*].id, count.index)
  route_table_id = aws_route_table.jhooq_public_route_table.id
} */


resource "aws_route_table_association" "private_subnet_asso" {
    count = length(var.cidr_private_subnet)
    depends_on = [aws_subnet.private_subnet_us-west-2, aws_route_table.us-west-rtb-private]
  subnet_id      = element(aws_subnet.private_subnet_us-west-2[*].id, count.index)
  route_table_id = aws_route_table.us-west-rtb-private[count.index].id
}

/* resource "aws_route_table_association" "private_subnet_association" {
  count = length(var.cidr_private_subnet)
  depends_on = [aws_subnet.aws_jhooq_private_subnets, aws_route_table.jhooq_private_route_table]
  subnet_id      = element(aws_subnet.aws_jhooq_private_subnets[*].id, count.index)
  route_table_id = aws_route_table.jhooq_private_route_table[count.index].id
} */