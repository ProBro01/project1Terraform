resource "aws_key_pair" "project1KeyPair" {
  key_name   = "project1keypair"
  public_key = file("C:\\Users\\Aryan\\.ssh\\id_rsa.pub")
}

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

resource "aws_instance" "hostVMs" {
  # provider      = aws.webIAMuser
  instance_type = var.hostInstanceType
  count         = 2
  ami           = count.index == 0 ? var.ubuntuAMI : var.amazonLinuxAMI
  key_name      = aws_key_pair.project1KeyPair.key_name
  tags = {
    Name = format("hostVM-%d", count.index)
  }

  

  vpc_security_group_ids = [aws_security_group.hostingVMSecGroup.id]

}
