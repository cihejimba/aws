provider aws {
  region = "us-east-1"
}

resource aws_iam_user myuser {
  name = "iamuser-${count.index}"
  count = 3
  path = "/system/"
}

output arns {
  value = aws_iam_user.myuser[*].arn
}

output names {
  value = aws_iam_user.myuser[*].name
}
