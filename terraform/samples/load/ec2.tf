resource "aws_instance" "dev" {
  ami = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
}
