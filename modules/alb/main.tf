resource "aws_lb" "this" {
  name               = "${var.project}-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "${var.project}-ALB"
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.project}-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project}-TG"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group_attachment" "web" {
  count            = length(var.web_instance_ids)
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.web_instance_ids[count.index]
  port             = 80
}
