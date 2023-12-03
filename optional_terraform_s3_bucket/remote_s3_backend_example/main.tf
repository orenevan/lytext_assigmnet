
#------ Example how to use terraform backend from S3 
## previously created by terraform_remote_state_s3_buckets

# data "terraform_remote_state" "buckets" {
#   backend = "local"

#   config = {
#     path = "../terraform_remote_state_s3_buckets/terraform.tfstate"
#   }
# }


# locals {
#   bucket = data.terraform_remote_state.buckets.outputs.tf_state_bucket_companya
 
# }

# terraform {
#   backend "s3" {
#     bucket = local.bucket
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#   }
# }

# output "tf_state_bucket_companya" {
#   value = local.bucket
# }

