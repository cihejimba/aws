resource "aws_s3_bucket" "default" {
  bucket_prefix = "beanstalk-"
  tags = local.env_tag
}

# https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/samples/python.zip
resource "null_resource" "webapp" {
  provisioner "local-exec" {
    command = "curl -L https://github.com/ThaiDangFr/helloworld-django/archive/refs/heads/main.zip -o webapp.zip"
  }
}

resource "aws_s3_object" "default" {
  depends_on = [null_resource.webapp]
  
  bucket = aws_s3_bucket.default.id
  key    = "webapp.zip"
  source = "webapp.zip"

provisioner "local-exec" {
    command = "rm -f webapp.zip"
  }  
}
