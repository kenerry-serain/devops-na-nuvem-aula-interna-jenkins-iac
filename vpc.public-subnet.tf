resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.0.0/26"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "jenkins-vpc-public-subnet"
  }
}