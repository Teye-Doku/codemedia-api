resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name      #"terraform-masterclass-bucket"
  
#   lifecycle {
#       prevent_destroy = true
#   }

  versioning {
     enabled = true
  }

  //encryption
  server_side_encryption_configuration {
      rule {
          apply_server_side_encryption_by_default {
             sse_algorithm = "AES256"
          }
      }
  }
}

resource "aws_dynamodb_table" "terraform-locks" {
  name =  var.dynamodb_name   #"terraform-state-locks-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
     name = "LockID"
     type = "S"
  }
}