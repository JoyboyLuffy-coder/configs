variable "subnets" {
  default = {
    public-1  = { cidr = "10.0.1.0/24", az = "us-east-1a", public = true }
    public-2  = { cidr = "10.0.2.0/24", az = "us-east-1b", public = true }
    private-1 = { cidr = "10.0.3.0/24", az = "us-east-1c", public = false }
    private-2 = { cidr = "10.0.4.0/24", az = "us-east-1d", public = false }
  }
}

resource "aws_subnet" "luffy" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.luffy-vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.public
  tags = {
    Name = "luffy-$(each.key)"
  }
}