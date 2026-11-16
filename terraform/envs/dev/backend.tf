terraform {
  backend "s3" {
    bucket       = "cdr-logs-825990809758"   # same bucket CDR uses
    key          = "eks/dev/terraform.tfstate"
    region       = "us-east-1"                # change if your bucket is elsewhere
    encrypt      = true
    use_lockfile = true                       # the "busy" sign
  }
}
