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

# https://automateinfra.com/2021/03/24/how-to-launch-aws-elastic-beanstalk-using-terraform/
#aws elasticbeanstalk list-available-solution-stacks
#64bit Amazon Linux 2 v3.3.14 running Python 3.8
resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name                = "tf-test-name"
  application         = aws_elastic_beanstalk_application.tftest.name
  solution_stack_name = "64bit Amazon Linux 2 v3.3.14 running Python 3.8"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "vpc-0e75a6c12ef09bc6c"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "subnet-06d429be7739347da,subnet-038d83167aa1aa1f5"
  }

    setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  "aws-elasticbeanstalk-ec2-role"
  }
}
