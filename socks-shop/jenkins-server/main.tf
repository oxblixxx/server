terraform {
  backend "s3" {
    bucket = "socks-shop-state-file-12-23-03"
    key    = "newkey-e1/terraform.tfstate"
    region = "us-east-1"
    #    dynamodb_table = "state-file-socks-web"
  }
}

