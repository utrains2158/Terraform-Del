# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket  = "samka-source-bucket"
    key     = "aurora-project"
    region  = "us-east-1"
    profile = "default"
    #dynamodb_table = 
  }
}