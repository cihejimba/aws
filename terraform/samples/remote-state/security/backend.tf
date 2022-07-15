terraform {
  backend "s3" {
    bucket = "199603965279-terraform"
    key    = "security/sg.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-statelock"
  }
}
