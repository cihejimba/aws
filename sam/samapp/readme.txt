# https://seanjziegler.com/how-to-build-an-api-with-aws-lambda-and-api-gateway-using-aws-sam/
# https://www.honeybadger.io/blog/ruby-aws-lambda/
# https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-policy-templates.html
# https://github.com/awsdocs/aws-doc-sdk-examples/blob/main/ruby/example_code/sqs/sqs-ruby-example-send-receive-messages.rb

first time
==========
sam init
sam local generate-event apigateway aws-proxy > events/translate.json
sam local invoke -e events/translate.json
sam deploy --guided

marche pas ?
============
sam local invoke -e events/translate.json

  "errorMessage": "The security token included in the request is invalid",
  "errorType": "Function<Aws::DynamoDB::Errors::UnrecognizedClientException>",


build et deploy
===============
sam build && sam deploy

test 
====
curl -X POST https://o0d6eai1rj.execute-api.us-east-1.amazonaws.com/Prod/translate?text=salut
