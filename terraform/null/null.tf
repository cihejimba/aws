provider "aws" {
  region = "us-east-1"
}

resource aws_eip myeip {
  vpc = true
  count = 2
#  depends_on = [null_resource.health_check]
}

resource null_resource ip_check {
  triggers = {
    latest_ips = join(",", aws_eip.myeip[*].public_ip)
  }

  
  provisioner local-exec {
    command = "echo ${null_resource.ip_check.triggers.latest_ips} > ips.txt"
  }
}
