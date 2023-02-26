data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "from-alb" {
  vpc_id      = aws_vpc.main.id
  name        = "from-alb"
  description = "security group that allows traffic only from a load balancer"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.alb.id]
  }
  tags = {
    Name = "from-alb"
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  security_group_id = aws_security_group.from-alb.id
}

resource "aws_security_group" "alb" {
  vpc_id      = aws_vpc.main.id
  name        = "alb"
  description = "security group that allows traffic only on port 80"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb"
  }
}