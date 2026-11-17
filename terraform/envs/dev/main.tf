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

variable "admin_cidr" {
  type = string
}

module "eks" {
  source             = "../../modules/eks"
  cluster_name       = local.cluster_name
  kubernetes_version = "1.37"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnets
  admin_cidr         = var.admin_cidr
}

output "cluster_name" {
  value = module.eks.cluster_name
}
