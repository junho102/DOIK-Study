resource "aws_vpc" "vpc" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = join("-", ["${local.project_name}", "${local.vpc_name}", "${local.env}"])
  }
}