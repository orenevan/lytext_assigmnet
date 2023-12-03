
resource "aws_s3_bucket" "tf_state_bucket_companya" {
  bucket = "terraform-tfstate-${random_id.example.hex}"
}

resource "random_id" "example" {
  byte_length = 8
}

resource "aws_s3_bucket_versioning" "state_versioninga" {
  bucket = aws_s3_bucket.tf_state_bucket_companya.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket" "tf_state_bucket_companyb" {
  bucket = "terraform-tfstate-${random_id.exampleb.hex}"
}

resource "random_id" "exampleb" {
  byte_length = 8
}

resource "aws_s3_bucket_versioning" "state_versioningb" {
  bucket = aws_s3_bucket.tf_state_bucket_companyb.id
  versioning_configuration {
    status = "Enabled"
  }
}


# data "terraform_remote_state" "foo" {
#   backend = "local"

#   config = {
#     path = "terraform.tfstate"
#   }
# }
# output "companya_output_2" {
#   value = data.terraform_remote_state.foo.outputs
#   # aws_s3_bucket.tf_state.bucket
# }


output "tf_state_bucket_companya" {
  value = "${aws_s3_bucket.tf_state_bucket_companya.bucket}"
}

output "tf_state_bucket_companyb" {
  value = "${aws_s3_bucket.tf_state_bucket_companya.bucket}"
}


