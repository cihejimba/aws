terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.22.0"
    }
  }

}

provider "aws" {
  default_tags {
    tags = local.provider_tag
  }
}



