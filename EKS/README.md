# terraform-aws-EKS-without-vpc

## 사용법(Usage)

> 💡 참고 : 환경변수가 사전에 구성되어 있어야 하며, 리눅스 계열에서 동작합니다. (env.sh 파일참고)  
> export AWS_ACCESS_KEY_ID=<액세스 키>  
> export AWS_SECRET_ACCESS_KEY=<시크릿 액세스 키>  

### 모듈 사용예제(Module Examples)

```ruby
terraform {
  cloud {
    # 참석자의 조직명 기입
    organization = "my-mega"

    workspaces {
      # 참석자의 워크스페이스명 기입
      name = "my-eks"
    }
  }
}

provider "aws" {
  region      = "ap-northeast-2"
}

module "tfe" {
  source  = "./eks"
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

### EKS 유저 추가
배포가 완료되고 kubeconfig까지 받아온 다음, 다른환경(예를 들어 local에서)에서 자신의 iam계정 권한으로 kubeconfig를 받아와도 kubectl 명령어의 실행권한이 없을 수 있다.
이러한 경우에 다음과 같은 사전작업이 필요하다.

```ruby
#aws-auth configmap을 수정한다.
kubectl edit -n kube-system configmap/aws-auth

#아래는 configmap/aws-auth 전문이다.
apiVersion: v1
data:
  mapRoles: |
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: arn:aws:iam::443619064129:role/eks_cluster-nodegroup-eks-node-group-20231010030230795600000003
      username: system:node:{{EC2PrivateDNSName}}
#이 부분부터 추가한다.
  mapUsers: |
    - groups:
      - system:masters
      #자신의 iam 유저의 arn을 추가한다. 
      userarn: arn:aws:iam::443619064129:user/unghee
      #자신의 iam 유저의 name을 추가한다.
      username: unghee
kind: ConfigMap
metadata:
  creationTimestamp: "2023-10-10T03:12:31Z"
  name: aws-auth
  namespace: kube-system
  resourceVersion: "1190509"
  uid: 1ee54bbe-3c97-4859-a8b7-d385d47ecab2
```

해당 작업이후 동일하게 kubeconfig 생성명령어를 진행한다.
