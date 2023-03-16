variable "aws_region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "socks-web-shop-eks"
  type    = string
}

variable "instance_type" {
  default = "t2.small"
}

variable "availabilty_zone" {
  default = "us-east-1a"
}