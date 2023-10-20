resource "aws_subnet" "pub_subnet" {
  count                   = length(local.pub_cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(local.pub_cidr, count.index)
  availability_zone       = ((count.index) % 2) == 0 ? local.zone_id_a : local.zone_id_c
  map_public_ip_on_launch = true

  tags = {
    Name = join("-", ["${local.project_name}", "pub", "${local.subnet_name}", "${local.env}", "${((count.index) % 2) == 0 ? "a" : "c"}"])
  }
}

resource "aws_subnet" "pri_subnet" {
  count             = length(local.pri_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(local.pri_cidr, count.index)
  availability_zone = ((count.index) % 2) == 0 ? local.zone_id_a : local.zone_id_c

  tags = {
    Name = join("-", ["${local.project_name}", "pri", "${local.subnet_name}", "${local.env}", "${((count.index) % 2) == 0 ? "a" : "c"}"])
  }
}

resource "aws_subnet" "db_subnet" {
  count             = length(local.db_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(local.db_cidr, count.index)
  availability_zone = ((count.index) % 2) == 0 ? local.zone_id_a : local.zone_id_c

  tags = {
    Name = join("-", ["${local.project_name}", "db", "${local.subnet_name}", "${local.env}", "${((count.index) % 2) == 0 ? "a" : "c"}"])
  }
}