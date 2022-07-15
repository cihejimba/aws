provider "aws" {
  region = "us-east-1"
}

variable "usernames" {
  type = list
  default = ["john", "paul"]
}

resource "aws_iam_user" "myiam" {
  name = var.usernames[count.index]
  count = 2
}
