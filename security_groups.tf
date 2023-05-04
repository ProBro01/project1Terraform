resource "aws_security_group" "hostingVMSecGroup" {
  name = "hostingVMSecGroup"
}

resource "aws_security_group" "lbSecGroup" {
  name = "lbSecGroup"
}

