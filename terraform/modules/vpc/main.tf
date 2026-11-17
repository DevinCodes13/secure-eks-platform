data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.6"

  name = var.name
  cidr = var.cidr
  azs  = local.azs

  # Big inside streets for the cluster, small front streets for load balancers
  private_subnets = [for i, az in local.azs : cidrsubnet(var.cidr, 4, i)]
  public_subnets  = [for i, az in local.azs : cidrsubnet(var.cidr, 8, 48 + i)]

  enable_nat_gateway   = true
  single_nat_gateway   = true   # one mail slot = cheaper (fine for dev)
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Name tags so Kubernetes knows which streets to use
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "karpenter.sh/discovery"          = var.cluster_name
  }
}
