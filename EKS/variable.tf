variable "eks_cluster_name" {}

variable "eks_cluster_node_group_name" {}

variable "eks_cluster_version" {}

variable "ec2_key_pair" {}

variable "worker_node_instance_type" {
  default = ["t3.xlarge"]
}

variable "worker_node_min_size" {}

variable "worker_node_max_size" {}

variable "worker_node_desired_size" {}

variable "aws_region" {}

variable "var_subnet_1_az" {
  default = "ap-northeast-2a"
}

variable "var_subnet_2_az" {
  default = "ap-northeast-2c"
}

variable "vpc_id" {}

variable "pri_subnets_ids" {}

variable "pub_subnets_ids" {}

locals {
  eks_cluster_name            = var.eks_cluster_name
  eks_cluster_node_group_name = var.eks_cluster_node_group_name
  eks_cluster_version         = var.eks_cluster_version
  ec2_key_pair                = var.ec2_key_pair
  worker_node_instance_type   = var.worker_node_instance_type
  worker_node_max_size        = var.worker_node_max_size
  worker_node_min_size        = var.worker_node_min_size
  worker_node_desired_size    = var.worker_node_desired_size
  aws_region                  = var.aws_region
  var_subnet_1_az             = var.var_subnet_1_az
  var_subnet_2_az             = var.var_subnet_2_az
  pri_subnets_ids             = var.pri_subnets_ids
  pub_subnets_ids             = var.pub_subnets_ids
  vpc_id                      = var.vpc_id

  tags = {
  }
}
