terraform {
  backend "s3" {
    bucket = "db-terraform-tfstate-backendd"
    key    = "projects/myapp3/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}