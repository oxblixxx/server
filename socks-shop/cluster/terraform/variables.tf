variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr_blocks" {
  default = ["10.0.16.0/24", "10.0.17.0/24", "10.0.18.0/24"]
}

variable "public_subnet_cidr_blocks" {
  default = ["10.0.5.0/24", "10.0.6.0/24", "10.0.5.0/24"]
}

variable "cluster_name" {
  default = "socks-web-shop-eks"
  type    = string
}