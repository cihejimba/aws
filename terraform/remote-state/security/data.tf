data terraform_remote_state eip {
  backend = "s3"
  config = {
    bucket = "199603965279-terraform"
    key    = "network/eip.tfstate"
    region = "us-east-1"
  }
}
