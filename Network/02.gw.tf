resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = join("-", ["${local.project_name}", "${local.igw_name}", "${local.env}"])
  }
}

resource "aws_eip" "natgw_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natgw_az1" {
  allocation_id = aws_eip.natgw_ip.id
  subnet_id     = aws_subnet.pub_subnet.0.id

  tags = {
    Name = join("-", ["${local.project_name}", "${local.natgw_name}", "${local.env}"])
  }

  depends_on = [aws_internet_gateway.igw]
}