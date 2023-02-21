#data "http" "myip" {
#  url = "http://ipv4.icanhazip.com"
#}

resource "aws_security_group" "allow-all" {
#  vpc_id      = var.VPC_ID
  vpc_id      = aws_vpc.main.id
  name        = "allow-all"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
#    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-all"
  }
}