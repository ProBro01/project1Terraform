resource "aws_vpc_security_group_ingress_rule" "webHostingSecRule" {
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
  security_group_id = [
    aws_security_group.hostingVMSecGroup.id,
    aws_security_group.lbSecGroup.id
  ]
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "webHostingSecRuleHTTPS" {
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
  security_group_id = [
    aws_security_group.hostingVMSecGroup.id,
    aws_security_group.lbSecGroup.id
  ]
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "webHostingSSHRule" {
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
  security_group_id = [
    aws_security_group.hostingVMSecGroup.id
  ]
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "webHostingOutboundRule" {
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 443
  security_group_id = [
    aws_security_group.hostingVMSecGroup.id
  ]
  cidr_ipv4 = "0.0.0.0/0"
}
