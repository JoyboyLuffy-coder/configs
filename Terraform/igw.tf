resource "aws_internet_gateway" "luffy-igw" {
  tags = {
    name   = "luffy-igw"
    vpc_id = aws_vpc.luffy-vpc.id
  }
}