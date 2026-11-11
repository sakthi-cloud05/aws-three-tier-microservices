resource "aws_lb" "external_alb" {
  name               = "three-tier-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_1a.id, aws_subnet.public_1b.id]

  tags = {
    Name = "production-alb"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name        = "app-target-group"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/health"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.external_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
