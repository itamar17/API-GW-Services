resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

# Target group
resource "aws_lb_target_group" "default-target-group" {
  name     = "demo-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 60
    matcher             = "200"
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.default-target-group.arn
  target_id        = aws_instance.be.id
  port             = 80
}

resource "aws_lb_listener" "ec2-alb-http-listener" {
  load_balancer_arn = aws_lb.alb.id
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_lb_target_group.default-target-group]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default-target-group.arn
  }
}