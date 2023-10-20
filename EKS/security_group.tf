resource "aws_security_group" "security_group_eks_cluster" {
  name        = "security_group_eks_cluster"
  description = "security_group_eks_cluster"
  vpc_id      = local.vpc_id
  tags = {
    "Name" = "security_group_eks_cluster"
  }
}

resource "aws_security_group_rule" "security_group_rule_eks_cluster_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_eks_cluster.id
}

resource "aws_security_group_rule" "security_group_rule_eks_cluster_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_eks_cluster.id
}
