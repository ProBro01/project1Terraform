resource "aws_security_group" "hostingVMSecGroup" {
  name        = "hostingVMSecGroup"
  # description = "rule for hosting VM's without ssh"
}

resource "aws_vpc_security_group_ingress_rule" "webHostingSecRule" {
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  security_group_id = aws_security_group.hostingVMSecGroup.id
  cidr_ipv4         = "0.0.0.0/0"
}
