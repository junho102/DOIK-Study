module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                          = local.eks_cluster_name
  cluster_version                       = local.eks_cluster_version
  cluster_endpoint_private_access       = true
  cluster_endpoint_public_access        = true
  cluster_additional_security_group_ids = [aws_security_group.security_group_eks_cluster.id]

  vpc_id     = local.vpc_id
  subnet_ids = local.pri_subnets_ids

  eks_managed_node_groups = {
    "${local.eks_cluster_node_group_name}" = {
      desired_size   = local.worker_node_desired_size
      max_size       = local.worker_node_max_size
      min_size       = local.worker_node_min_size
      instance_types = local.worker_node_instance_type
    }
  }

}
