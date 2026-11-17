locals {
  cluster_name = "secure-eks-dev"
}

module "vpc" {
  source       = "../../modules/vpc"
  name         = "secure-eks-dev"
  cidr         = "10.0.0.0/16"
  cluster_name = local.cluster_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
