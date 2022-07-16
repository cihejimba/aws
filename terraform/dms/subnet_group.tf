# Create a new replication subnet group
resource "aws_dms_replication_subnet_group" "postgres-subnet-group" {
  replication_subnet_group_description = "postgres replication subnet group"
  replication_subnet_group_id          = "postgres-dms-replication-subnet-group-tf"

  subnet_ids = var.repli_instance_subnetids

  tags = {
    Name = "postgres-subnet-group"
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.dms-vpc-role-AmazonDMSVPCManagementRole
  ]
}
