resource "aws_lb" "hostingVMlb" {
  name               = "hostingVMlb"
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.hostingVMSecGroup.id]
  internal           = false
  subnets            = ["subnet-056b2d88f2a9440ea", "subnet-0f7eca0f4793e210b"]
}

resource "aws_lb_listener" "lbListener" {
  port                   = 80
  protocol               = "HTTP"
  load_load_balancer_arn = aws_lb.hostingVMlb.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hostTargetGroup.arn
  }
}

