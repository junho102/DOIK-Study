data "external" "env" {
  program = ["${path.module}/env.sh"]
}

resource "aws_instance" "ec2_bastion_host" {

  depends_on = [
    local.vpc_id
  ]

  ami                         = data.aws_ami.amazon_linux_2.id
  associate_public_ip_address = true
  instance_type               = "t3.medium"
  key_name                    = local.ec2_key_pair
  vpc_security_group_ids      = ["${aws_security_group.security_group_eks_cluster.id}"]
  subnet_id                   = element(local.pub_subnets_ids, 0)

  tags = {
    Name = "ec2_bastion_host"
  }
}
