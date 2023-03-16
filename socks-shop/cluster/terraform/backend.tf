terraform {
  backend "s3" {
    bucket = "socks-shop-state-file-12-23-03"
    key    = "socks-cluster/terraform.tfstate"
    region = "us-east-1"
    #    dynamodb_table = "state-file-socks-web"
  }
}

