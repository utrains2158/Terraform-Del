
output "cluster_instance" {
  value = aws_rds_cluster_instance.samka_aurora_cluster_instances
}

output "cluster" {
  value = aws_rds_cluster.samka_aurora-cluster
}