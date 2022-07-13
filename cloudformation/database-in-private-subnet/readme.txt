# https://github.com/Integralist/CloudFormation/blob/master/redis.yaml
lancer
create-network.sh
create-database.sh

rds-network-DBSecurityGroup = SG du RDS, autorise seulement l'accès au rds-network-WebServerSecurityGroup
rds-network-WebServerSecurityGroup = SG a attacher au serveur web


create-redis.sh
