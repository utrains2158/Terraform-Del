
resource "aws_security_group" "samka_rds_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.ingress_ports
    to_port     = var.ingress_ports
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = var.egress_ports
    to_port     = var.egress_ports
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }
  tags = merge(var.my_tags, {
    Name = format("%s-%s-%s-security-group", var.my_tags["ID_Num"], var.my_tags["env"], var.my_tagstags["project"])
    },
  )
}

resource "aws_db_subnet_group" "samka_subnet_group" {
  name       = "samka_subnet-group"
  subnet_ids = var.subnet_ids
  tags = merge(var.my_tags, {
    Name = format("%s-%s-%s-subnet-group", var.my_tags["ID_Num"], var.my_tags["env"], var.my_tagstags["project"])
    },
  )

}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "db-creds"
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

resource "aws_rds_cluster_parameter_group" "samka_parameter_group" {
  name        = var.param_name
  family      = var.param_family
  description = var.param_description
}

resource "aws_rds_cluster" "samka_aurora-cluster" {
  cluster_identifier              = var.samka_cluster["cluster_identifier"]
  engine                          = var.samka_cluster["engine"]
  engine_version                  = var.samka_cluster["engine_version"]
  database_name                   = var.samka_cluster["database_name"]
  master_username                 = local.db_creds.master_username
  master_password                 = local.db_creds.master_password
  db_subnet_group_name            = aws_db_subnet_group.samka_subnet_group.name
  vpc_security_group_ids          = [aws_security_group.samka_rds_sg.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.samka_parameter_group.name
  skip_final_snapshot             = var.samka_cluster["skip_final_snapshot"]
  storage_encrypted       = var.samka_cluster["storage_encrypted"]
  backup_retention_period = var.samka_cluster["backup_retention_period"]
  preferred_backup_window = var.samka_cluster["preferred_backup_window"]
  deletion_protection     = var.samka_cluster["deletion_protection"]
  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }
 tags = merge(var.my_tags, {
    Name = format("%s-%s-%s-auroa_cluster", var.my_tags["ID_Num"], var.my_tags["env"], var.my_tagstags["project"])
    },
  )
}

resource "aws_rds_cluster_instance" "samka_aurora_cluster_instances" {
  count                = var.samka_cluster["count"]
  cluster_identifier   = aws_rds_cluster.samka_aurora-cluster.id
  instance_class       = var.samka_cluster["instance_class "]
  engine               = var.samka_cluster["engine "]
  engine_version       = var.samka_cluster["engine_version "]
  publicly_accessible  = var.samka_cluster["publicly_accessible"]
  db_subnet_group_name = aws_db_subnet_group.samka_subnet_group.name
  identifier           = "aurora_cluster_instances-${count.index + 1}"
  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }
  tags = merge(var.my_tags, {
    Name = format("%s-%s-%s-auroa_cluster_instance-${count.index + 1}", var.my_tags["ID_Num"], var.my_tags["env"], var.my_tagstags["project"])
    },
  )
}
