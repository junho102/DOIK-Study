####### public routing table #######
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = join("-", ["${local.project_name}", "pub", "${local.rt_name}", "${local.env}"]) }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_asso_rt" {
  count          = length(aws_subnet.pub_subnet)
  subnet_id      = element(aws_subnet.pub_subnet.*.id, count.index)
  route_table_id = aws_route_table.route_table_public.id
}


####### private routing table #######
resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = join("-", ["${local.project_name}", "pri", "${local.rt_name}", "${local.env}"]) }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.route_table_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_az1.id
}

resource "aws_route_table_association" "private_asso_rt" {
  count          = length(aws_subnet.pri_subnet)
  subnet_id      = element(aws_subnet.pri_subnet.*.id, count.index)
  route_table_id = aws_route_table.route_table_private.id
}


####### db routing table #######
resource "aws_route_table" "route_table_db" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = join("-", ["${local.project_name}", "db", "${local.rt_name}", "${local.env}"]) }
}

resource "aws_route" "db_route" {
  route_table_id         = aws_route_table.route_table_db.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_az1.id
}

resource "aws_route_table_association" "db_asso_rt" {
  count          = length(aws_subnet.db_subnet)
  subnet_id      = element(aws_subnet.db_subnet.*.id, count.index)
  route_table_id = aws_route_table.route_table_db.id
}