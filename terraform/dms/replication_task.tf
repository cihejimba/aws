# Create a new replication task
resource "aws_dms_replication_task" "postgres_replication_task" {
  
  migration_type            = "full-load"
  replication_instance_arn  = aws_dms_replication_instance.migration-postgres.replication_instance_arn
  replication_task_id       = "postgres-dms-replication-task-tf"
  replication_task_settings = "${data.template_file.task_settings.rendered}"
  source_endpoint_arn       = aws_dms_endpoint.src_endpoint.endpoint_arn
  #table_mappings            = "{\"rules\":[{\"rule-type\":\"selection\",\"rule-id\":\"1\",\"rule-name\":\"1\",\"object-locator\":{\"schema-name\":\"%\",\"table-name\":\"%\"},\"rule-action\":\"include\"}]}"
  table_mappings            = "${data.template_file.table_mappings.rendered}"
  tags = {
    Name = "postgres_replication_task"
  }

  target_endpoint_arn = aws_dms_endpoint.dst_endpoint.endpoint_arn
}

# Reference the DMS table mappings
data "template_file" "table_mappings" {
  template = "${file("table_mappings.tpl")}"
}

data "template_file" "task_settings" {
  template = "${file("task_settings.tpl")}"
}
