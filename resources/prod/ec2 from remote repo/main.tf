locals {
  aws_region                    = "us-east-1"
  ec2_instance_type             = "t3.micro"
  vpc_id                        = "vpc-068852590ea4b093b"
  subnet_id                     = "subnet-096d45c28d9fb4c14"
  root_volume_size              = 10
  tags = {
   "id"             = "2560"
    "owner"          = "DevOps"
    "teams"          = "prod"
    "environment"    = "dev"
    "project"        = "samka"
    "create_by"      = "a1samka"
    "cloud_provider" = "aws"
}
  }

module "ec2" {
  source                        = "github.com/utrains2158/aurora-postgress-module/module/ec2"
  aws_region                    = local.aws_region
  ec2_instance_type             = local.ec2_instance_type
  vpc_id                        = local.vpc_id
  subnet_id                     = local.subnet_id
  root_volume_size              = local.root_volume_size
  tags                          = local.tags
}