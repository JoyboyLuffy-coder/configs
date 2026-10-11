resource "aws_vpc_peering_connection" "luffy-vpc_peering" {
  tags = {
    Name = "luffy-vpc_peering"
  }
  vpc_id      = data.aws_vpc.default.id
  peer_vpc_id = aws_vpc.luffy-vpc.id

}

