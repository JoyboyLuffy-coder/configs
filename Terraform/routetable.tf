resource "aws_route_table" "luffy-public-rtb" {
  vpc_id = aws_vpc.luffy-vpc.id
  tags = {
    Name = "luffy-public-rtb"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.luffy-igw.id

  }
  route {
    cidr_block                = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.luffy-vpc_peering.id
  }

}

resource "aws_route" "default-to-other-vpc" {
  route_table_id            = data.aws_vpc.default.main_route_table_id
  destination_cidr_block    = aws_vpc.luffy-vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.luffy-vpc_peering.id
}
resource "aws_route_table" "luffy-private-rtb" {
  vpc_id = aws_vpc.luffy-vpc.id
  tags = {
    Name = "luffy-private-rtb"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.luffy-ngw.id
  }
}

resource "aws_route_table_association" "luffy-public-rtb-assoc" {
  for_each = {
    for k, v in var.subnets : k => v if v.public
  }
  subnet_id      = aws_subnet.luffy[each.key].id
  route_table_id = aws_route_table.luffy-public-rtb.id

}

resource "aws_route_table_association" "luffy-private-rtb-assoc" {
  for_each = {
    for k, v in var.subnets : k => v if !v.public
  }
  subnet_id      = aws_subnet.luffy[each.key].id
  route_table_id = aws_route_table.luffy-private-rtb.id
}