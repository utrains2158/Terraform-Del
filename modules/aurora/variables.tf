
# tags
variable "my_tags" {
  type = map(any)
  default = {
    "ID_Num"       = "5555"
    "create_by"     = "samka"
    "env"           = "dev"
    "project"       = "Data-base"
    "cloudProvider" = "aws"
  }
}


# SG vpc

variable "vpc_id" {
    type = string
    default = "vpc-083552590ea4b09z4"
}


# SG ingress
variable "ingress_ports" {
    type = number
    default = 5432
}

variable "ingress_protocol" {
    type = string
    default = "tcp"
}

variable "ingress_cidr_blocks" {
    type = list(string)
    default = ["0.0.0.0/0"]
}


# SG egress
variable "egress_ports" {
    type = number
    default = 0
}

variable "egress_protocol" {
    type = string
    default = "-1"
}

variable "egress_cidr_blocks" {
    type = list(string)
    default = ["0.0.0.0/0"]
}

# Subnet
variable "subnet_ids" {
    type = list(string)
    default = ["subnet-459d45c28d9fbwe12", "subnet-78w285a3517372he3"]
}

# Parameter

variable "param_name" {
    type = string
    default = "samka-clter-param-group"
}

variable "param_family" {
    type = string
    default = "aurora-postgresql11"
}

variable "param_description" {
    type = string
    default = "Cluster parameter group"
}

# aws_rds_cluster

variable "samka_cluster" {
    type = map(any)
    default = {
        "cluster_identifier"              = "aurora-postgres-cluster"
        "engine"                          = "aurora-postgresql"
        "engine_version"                  = "11.9"
        "database_name"                   = "samka_DB"
        "skip_final_snapshot"             = true # Set to false if you want to take a final snapshot when deleting the cluster
        "storage_encrypted"       = true
        "backup_retention_period" = 4
        "preferred_backup_window" = "07:00-09:00"
        "deletion_protection"     = false
    }
}

# cluster instance

variable "samka_cluster" {
    type = map(any)
    default = {
       "count"                = 2
       "instance_class "      = "db.r5.large"
       "engine "              = "aurora-postgresql"
       "engine_version"       = "11.9"
       "publicly_accessible"  = true
    }
}

