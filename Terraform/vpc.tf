resource "aws_vpc" "luffy-vpc" {
  tags = {
    Name = "luffy-vpc"
  }
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

data "aws_vpc" "default" {
  default = true
}