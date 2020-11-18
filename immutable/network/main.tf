resource "aws_subnet" "prod" {
  vpc_id     = var.vpc_id
  cidr_block = "10.2.0.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Prod"
  }
}