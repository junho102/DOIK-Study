variable "project_name" {}

variable "env" {}

variable "vpc_name" {}

variable "igw_name" {}

variable "natgw_name" {}

variable "rt_name" {}

variable "subnet_name" {}

variable "vpc_cidr" {}

variable "pub_cidr" {}

variable "pri_cidr" {}

variable "db_cidr" {}

data "aws_availability_zones" "az" {
  state = "available"
}
locals {
  project_name = var.project_name
  env          = var.env
  vpc_name     = var.vpc_name
  igw_name     = var.igw_name
  natgw_name   = var.natgw_name
  rt_name      = var.rt_name
  subnet_name  = var.subnet_name
  vpc_cidr     = var.vpc_cidr
  pub_cidr     = var.pub_cidr
  pri_cidr     = var.pri_cidr
  db_cidr      = var.db_cidr
  zone_id_a    = data.aws_availability_zones.az.names[0]
  zone_id_c    = data.aws_availability_zones.az.names[2]
}