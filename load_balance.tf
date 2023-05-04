resource "aws_lb" "hostingVMlb" {
    name = "hostingVMlb"
    ip_address_type = "ipv4"
    load_balancer_type = "application"
    security_groups = [ aws_security_group.hostingVMSecGroup.id ]
}