terraform {
  backend "s3" {
    bucket = "199603965279-terraform"
    key    = "network/eip.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-statelock"
  }
}
