# terraform-aws-EKS-without-vpc

## 사용법(Usage)

### 모듈 사용예제(Module Examples)

```ruby
provider "aws" {
  region      = "ap-northeast-2"
}

module "eks" {
  source  = "./EKS"
  eks_cluster_name = "eks_cluster"
  eks_cluster_node_group_name = "eks_cluster-nodegroup"
  eks_cluster_version = "1.24"
  ec2_key_pair = "dpt-ssh"
  worker_node_instance_type = ["t3.xlarge"]
  worker_node_max_size = 5
  worker_node_desired_size = 2
  worker_node_min_size = 2
  aws_region = "ap-northeast-2"
  var_subnet_1_az = "ap-northeast-2a"
  var_subnet_2_az = "ap-northeast-2c"
  vpc_id          = "vpc-0727409c64a3ac216"
  pri_subnets_ids     = ["subnet-087143a99bf04dd86","subnet-07d20a57c3b6ed193"]
  pub_subnets_ids     = ["subnet-0ba1ac5bc9e1e65b1","subnet-02b3346e04af2fde8"]
}
```

### 출력예시(Outputs)

| Name | Description | Type |
|------|-------------|------|
| EC2_BASTION_HOST_IP | bastion ip | string |
| EKS_NodeGroup_Name |nodegroup name | sting |
| EKS_NodeGroup_asg_Name | nodegroup asg name | string |
| cluster_endpoint | cluster endpoint | string |
| cluster_certificate_authority_data | eks kubeconfig data | string |

### KUBECONFIG 설정(Configure)
Terraform으로 EKS Module을 기반으로 배포 후 Bastion Host에 접속 후 `aws eks update-kubeconfig` 명령을 통해 `KUBECONFIG` 파일 업데이트

After deploying based on EKS Module with Terraform, access to Bastion Host and update `KUBECONFIG` file with `aws eks update-kubeconfig` command


```
# 완료 후 kubeconfig 생성 명령어
aws eks --region $AWS_DEFAULT_REGION update-kubeconfig --name $CLUSTER_NAME --kubeconfig ~/.kube/config
```
