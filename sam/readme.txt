samapp
Appli SAM = API GW + Lambda + DynamoDB + SQS
un texte un placé dans la base dynamodb et la référence dans la queue SQS
curl -X POST https://2rkzv65wz1.execute-api.us-east-1.amazonaws.com/Prod/translate?text=salut

 
workerapp
wortier tier ruby sinatra avec elasticbeanstalk
scrupte et traite la queue SQS
fait la traduction du texte et met le résultat dans la base dynamodb

