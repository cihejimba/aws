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

il faut avoir une dynamodb en local

sinon pour utiliser le dynamodb remote il faut positionner les access key
et dans .bashrc il faut exporter AWS_ACCESS_KEY_ID et AWS_SECRET_KEY

  AWS.config.update({
    accessKeyId: ENV['AWS_ACCESS_KEY_ID'],
    secretAccessKey: ENV['AWS_SECRET_KEY'],
    region: awsRegion
  });



build et deploy
===============
sam build && sam deploy

test 
====
curl -X POST https://o0d6eai1rj.execute-api.us-east-1.amazonaws.com/Prod/translate?text=salut
