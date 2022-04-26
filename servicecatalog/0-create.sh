
aws s3 sync --exclude "*" --include "*.yml" . s3://199603965279/service-catalog/
aws cloudformation deploy --stack-name service-catalog --template-file service-catalog-1.yml --parameter-overrides CloudFormationBucket=199603965279
