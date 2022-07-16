/*
resource "aws_security_group" "demo" {
  name        = "demo"
  description = "just a test"
  vpc_id      = var.vpc_id

}
*/

resource "aws_dms_endpoint" "src_endpoint" {
  database_name               = var.db_name
  endpoint_id                 = "src-endpoint"
  endpoint_type               = "source"
  engine_name                 = "postgres"
  username                    = var.db_user
  password                    = var.db_password
  port                        = var.db_port
  server_name                 = var.db_host
  ssl_mode                    = "require"

  tags = {
    Name = "src_endpoint"
  }

}

resource "aws_dms_endpoint" "dst_endpoint" {
  database_name               = var.dst_db_name
  endpoint_id                 = "dst-endpoint"
  endpoint_type               = "target"
  engine_name                 = "postgres"
  username                    = var.dst_db_user
  password                    = var.dst_db_password
  port                        = var.dst_db_port
  server_name                 = var.dst_db_host
  ssl_mode                    = "none"

  tags = {
    Name = "dst_endpoint"
  }

}

