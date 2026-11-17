provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project   = "secure-eks-platform"
      ManagedBy = "terraform"
      Env       = "dev"
    }
  }
}

variable "region" {
  type    = string
  default = "us-east-1"
}
