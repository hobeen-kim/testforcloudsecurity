terraform {
  backend "s3" {
    bucket         = "terraform-states-589794546244"
    key            = "routing/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
