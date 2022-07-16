terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.22.0"
    }
  }

  /*
  cloud {
    organization = "dangconsulting"

    workspaces {
      name = "whitebunny"
    }
  }
*/
}

provider "aws" {
  region = "ap-northeast-1"
}



