resource aws_eip eip1 {
  vpc = true
  provider = aws.us-east-1
}

resource aws_eip eip2 {
  vpc = true
  provider = aws.us-east-2
}
