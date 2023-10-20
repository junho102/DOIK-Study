AWS에서 VPC, Subnet, NAT GW, Route 설정 Terraform Moudle

<br>

## Usage
### module 사용 예제

```shell
module "main" {
  source       = "./modules/Network"

  # Required Inputs
  project_name = "dpt"
  subnet_name  = "sbn"
  env          = "common"
  vpc_name     = "vpc"
  igw_name     = "igw"
  natgw_name   = "nat"
  rt_name      = "rt"
  vpc_cidr     = "10.0.0.0/16"
  pub_cidr     = ["10.0.1.0/24", "10.0.2.0/24"]
  pri_cidr     = ["10.0.3.0/24", "10.0.4.0/24"]
  db_cidr      = ["10.0.5.0/24", "10.0.6.0/24"]
}
```
1. 해당 모듈은 3-tier achitecture 로 구성되어 있습니다.
2. subnet은 가용영역 A와 C만 사용하므로 위 "사용법"과 같이 custom하여 vpc 및 subnet cidr 대역대("vpc_cidr", "pub_cidr", "pri_cidr", "db_cidr")를 지정해주어 사용 가능합니다.
    - vpc_cidr : VPC의 CIDR 설정
    - pub_cidr : Public Subnet의 CIDR 설정
    - pri_cidr : Private Subnet의 CIDR 설정
    - db_cidr  : DB Subnet의 CIDR 설정
3. 해당 모듈의 Routing 설정은 다음과 같습니다.

    | Rout Table | Destination CIDR Block | Target |
    | --- | --- | --- |
    | Public Subnet | VPC CIDR | local |
    | | 0.0.0.0/0 | Internet Gateway |
    | Private Subnet | VPC CIDR | local |
    | | 팀원/일반사용자 | NAT Gateway |
    | DB Subnet | VPC CIDR | local |
    | | 팀원/일반사용자 | NAT Gateway |

### Inputs

| Name | Description | Type |
|------|-------------|------|
| project_name | 프로젝트 이름 | string |
| env | 운영환경 이름 | string |
| vpc_name | VPC 이름 | string |
| igw_name | Internet Gateway 이름 | string |
| natgw_name | NAT Gateway 이름 | string |
| rt_name | Routing Table 이름 | string |
| subnet_name | Subnet 이름 | string |
| vpc_cidr | VPC CIDR | string |
| pub_cidr | Public Subnet의 CIDR | string |
| pri_cidr | Private Subnet의 CIDR 이름 | string |
| db_cidr | DB Subnet의 CIDR 이름 | string |

### Outputs

| Name | Description | Type |
|------|-------------|------|
| vpc_id | vpc id 값 | string |
| pub_subnet | Public subnet | string |
| pri_subnet | Private subnet | string |
| db_subnet | DB subnet | string |
| public_route_table | Public subnet의 route table | string |
| private_route_table | Private subnet의 route table | string |
| db_route_table | DB subnet의 route table | string |