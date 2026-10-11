resource "aws_nat_gateway" "luffy-ngw" {
  vpc_id = aws_vpc.luffy-vpc.id
  availability_mode = "regional"
  tags = {
    Name = "luffy-ngw"
  }
  
  depends_on = [aws_internet_gateway.luffy-igw]
}