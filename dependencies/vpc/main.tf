
resource "aws_vpc" "prod" {
  cidr_block = "10.2.0.0/16"
}

resource "aws_subnet" "prod" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.2.0.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Prod"
  }
}