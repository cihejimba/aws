terraform {
  backend "s3" {
    bucket = "199603965279-terraform"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
