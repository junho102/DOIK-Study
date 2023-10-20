terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.12.0"
    }
  }
}
provider "aws" {
  region = "ap-northeast-2"
}

module "network" {
  source       = "./modules/Network"
  project_name = "eks"
  subnet_name  = "sbn"
  env          = "dev"
  vpc_name     = "vpc"
  igw_name     = "igw"
  natgw_name   = "nat"
  rt_name      = "rt"
  vpc_cidr     = "10.0.0.0/16"
  pub_cidr     = ["10.0.1.0/24", "10.0.2.0/24"]
  pri_cidr     = ["10.0.3.0/24", "10.0.4.0/24"]
  db_cidr      = ["10.0.5.0/24", "10.0.6.0/24"]
}

module "tfe" {
  source  = "./modules/EKS"
  eks_cluster_name = "eks_cluster"
  eks_cluster_node_group_name = "eks_cluster-nodegroup"
  eks_cluster_version = "1.24"
  ec2_key_pair = "my_aws_key"
  worker_node_instance_type = ["m5.xlarge"]
  worker_node_max_size = 4
  worker_node_desired_size = 2
  worker_node_min_size = 2
  aws_region = "ap-northeast-2"
  var_subnet_1_az = "ap-northeast-2a"
  var_subnet_2_az = "ap-northeast-2c"
  vpc_id          = module.network.vpc_id
  pri_subnets_ids     = module.network.pri_subnet.*.id
  pub_subnets_ids     = module.network.pub_subnet.*.id
}