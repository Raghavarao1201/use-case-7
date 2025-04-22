terraform {
  backend "s3" {
    bucket         = "use-case-7"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "use-case-7"
    use_lockfile = true
    encrypt = true
  }
}
