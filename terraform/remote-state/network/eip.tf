resource aws_eip myeip {
  vpc = true
}

output eip_addr {
  value = aws_eip.myeip.public_ip
}
