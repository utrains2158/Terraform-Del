# Define Local Values in Terraform

aws_region = "us-east-1"
environment = "test"
business_divsion = "qa"

cluster_name = "eks-test"
cluster_service_ipv4_cidr = "172.20.0.0/16"
cluster_version = "1.28"
cluster_endpoint_private_access = false
cluster_endpoint_public_access = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
