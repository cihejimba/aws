this script will create :
- source endpoint
- target endpoint
- replication instance in the same vpc than the target RDS
- migration task

todo :
- create a file terraform.tfvars from the sample
- terraform plan then terraform apply
- endpoints source and target, connections -> test connections
- database migration tasks -> 'resume/restart' to start the migration

an ec2 is create to simulate a web server with the security group to access to the database
2 scripts are in /root to connect to source database and target database
