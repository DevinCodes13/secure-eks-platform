module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids   # private streets only

  # The chef's office door: open only to your home IP, plus a private door inside the VPC
  endpoint_public_access       = true
  endpoint_public_access_cidrs = [var.admin_cidr]
  endpoint_private_access      = true

  # Make you (the Terraform user) a cluster admin
  enable_cluster_creator_admin_permissions = true
  authentication_mode = "API"

  # The diary
  enabled_log_types                      = ["api", "audit", "authenticator"]
  cloudwatch_log_group_retention_in_days = 7

  # Use EKS's built-in encryption (no custom KMS key to manage in dev)
  create_kms_key    = false
  encryption_config = null

  # Kitchen tools
  addons = {
    vpc-cni                = { before_compute = true }
    eks-pod-identity-agent = { before_compute = true }
    kube-proxy             = {}
    coredns                = {}
  }

  # The cooks
  eks_managed_node_groups = {
    default = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2

      iam_role_name            = "${var.cluster_name}-node"   # starts with secure-eks- to match our policy
      iam_role_use_name_prefix = true
    }
  }
}
