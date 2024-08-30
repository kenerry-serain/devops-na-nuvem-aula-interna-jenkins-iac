resource "aws_security_group" "this" {
  name   = "jenkins-ec2-instance"
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "jenkins-ec2-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "179.90.199.117/32"
  from_port         = "-1"
  ip_protocol       = "-1"
  to_port           = "-1"
}

resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
