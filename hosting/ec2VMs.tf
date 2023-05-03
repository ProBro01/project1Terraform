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

  provisioner "file" {
    source = count.index == 0 ? "./tempHostUbuntu.sh" : ".tempHostAmazon.sh"
    destination = count.index == 0 ? "/home/ubuntu/templateHostingScript.sh" : "/home/ec2-user/tempHostAmazon.sh"
  }

  provisioner "remote-exec" {
    script = "templateHostingScript.sh"
  }

  connection {
    type = "ssh"
    user = count.index == 0 ? "ubuntu" : "ec2-user"
    host = aws_instance.hostVMs[count.index].public_ip
    private_key = file("C:\\Users\\Aryan\\.ssh\\id_rsa")
  }

}
