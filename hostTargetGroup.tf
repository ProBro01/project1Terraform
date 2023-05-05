resource "aws_lb_target_group" "hostTargetGroup" {
  name            = "projectHostTargetGroup"
  port            = 80
  protocol        = "HTTP"
  target_type     = "instance"
  ip_address_type = "ipv4"

  health_check {
    enabled           = true
    healthy_threshold = 3
    interval          = 30
    path              = "/"
    port              = 80
    protocol          = "HTTP"
    timeout           = 6
  }

}

resource "aws_lb_target_group_attachment" "hostTarGroupAttachmentUbuntu" {
  target_group_arn = aws_lb_target_group.hostTargetGroup.arn
  target_id        = aws_instance.hostVMUbuntu.id
}

resource "aws_lb_target_group_attachment" "hostTarGroupAttachmentAmazon" {
  target_group_arn = aws_lb_target_group.hostTargetGroup.arn
  target_id        = aws_instance.hostVMAmazon.id
}
