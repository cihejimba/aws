locals {
  sec_grp_ids = [aws_security_group.webserver_sg.id, aws_security_group.rds_sg.id,aws_security_group.ec_sg.id,aws_security_group.alb_sg.id,aws_security_group.ecstask_sg.id]
}
