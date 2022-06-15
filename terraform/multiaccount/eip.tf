resource aws_eip eip1 {
  vpc = true
  provider = aws.compte1
}

resource aws_eip eip2 {
  vpc = true
  provider = aws.compte2
}
