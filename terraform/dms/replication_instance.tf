# Create a new replication instance
resource "aws_dms_replication_instance" "migration-postgres" {
  allocated_storage            = 20
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  availability_zone            = "ap-northeast-1a"
  #engine_version               = "3.1.4"
  #kms_key_arn                  = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
  multi_az                     = false
  #preferred_maintenance_window = "sun:10:30-sun:14:30"
  publicly_accessible          = true
  replication_instance_class   = "dms.t2.micro"
  replication_instance_id      = "postgres-dms-replication-instance-tf"
  replication_subnet_group_id  = aws_dms_replication_subnet_group.postgres-subnet-group.id
  
  
  tags = {
    Name = "postgres-dms-replication-instance-tf"
  }

  vpc_security_group_ids = [
    var.repli_instance_sg_id,
  ]

  depends_on = [
    aws_iam_role_policy_attachment.dms-access-for-endpoint-AmazonDMSRedshiftS3Role,
    aws_iam_role_policy_attachment.dms-cloudwatch-logs-role-AmazonDMSCloudWatchLogsRole,
    aws_iam_role_policy_attachment.dms-vpc-role-AmazonDMSVPCManagementRole
  ]
}
