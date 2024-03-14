variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# variable "ami" {
#   type    = string
#   default = " "
# }

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "samka-aws"
}

variable "vpc_id" {
  type    = string
  default = " "
}

# ingress aws_security_group_rule
variable "ingress_type" {
  type    = string
  default = "ingress"
}
variable "ingress_port" {
  type    = number
  default = 8080
}

variable "ingress_protocol" {
  type    = string
  default = "tcp"
}

variable "ingress_cidr_blocks" {
  type    = list(number)
  default = ["0.0.0.0/0"]
}
# egress aws_security_group_rule
variable "egress_type" {
  type    = string
  default = "egress"
}
variable "egress_port" {
  type    = number
  default = 0
}

variable "egress_protocol" {
  type    = number
  default = -1
}

variable "egress_cidr_blocks" {
  type    = list(number)
  default = ["0.0.0.0/0"]
}

# subnet
variable "subnet_id" {
  type    = string
  default = " "
}

variable "volume_size" {
  type    = string
  default = "10"
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2560"
    "owner"          = "DevOps"
    "teams"          = "Devops"
    "environment"    = "dev"
    "project"        = "samka"
    "create_by"      = "a1samka"
    "cloud_provider" = "aws"
  }
}

# backend variables
variable "aws_region_main" {
  type    = string
  default = "us-east-1"
}

variable "aws_region_backup" {
  type    = string
  default = "us-east-2"
}

