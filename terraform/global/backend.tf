terraform {
  backend "s3" {
    bucket       = "cdr-logs-825990809758"
    key          = "eks/global/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
