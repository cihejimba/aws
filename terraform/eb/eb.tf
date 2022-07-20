resource "aws_elastic_beanstalk_application" "tftest" {
  name        = "tf-test-name"
  description = "tf-test-desc"
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "tf-test-version-label"
  application = "tf-test-name"
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.default.id
  key         = aws_s3_object.default.id
}

#aws elasticbeanstalk list-available-solution-stacks
#64bit Amazon Linux 2 v3.3.14 running Python 3.8
resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name                = "tf-test-name"
  application         = aws_elastic_beanstalk_application.tftest.name
  solution_stack_name = "64bit Amazon Linux 2 v3.3.14 running Python 3.8"
}
