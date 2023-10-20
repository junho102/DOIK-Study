output "EC2_BASTION_HOST_IP" {
  value = aws_instance.ec2_bastion_host.public_ip
}

output "EKS_NodeGroup_Name" {
  value = element(split(":", module.eks.eks_managed_node_groups.eks_cluster-nodegroup.node_group_id), 1)
}

output "EKS_NodeGroup_asg_Name" {
  value = module.eks.eks_managed_node_groups_autoscaling_group_names
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "node_security_group_id" {
  value = module.eks.node_security_group_id
}

output "eks_managed_node_groups_arn" {
  value = module.eks.eks_managed_node_groups.eks_cluster-nodegroup.iam_role_arn
}