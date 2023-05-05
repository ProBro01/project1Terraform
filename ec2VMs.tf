
resource "aws_instance" "hostVMUbuntu" {
  instance_type = var.hostInstanceType
  ami           = var.ubuntuAMI
  key_name      = aws_key_pair.project1KeyPair.key_name
  tags = {
    Name = "hostVM-Ubuntu"
  }
  vpc_security_group_ids = [aws_security_group.hostingVMSecGroup.id]
  provisioner "file" {
    source      = "tempHostUbuntu.sh"
    destination = "/home/ubuntu/templateHostUbuntu.sh"
  }

  provisioner "file" {
    source      = "./html/index.html"
    destination = "/home/ubuntu/index.html"
  }
  provisioner "remote-exec" {
    script = "tempHostUbuntu.sh"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = file("C:\\Users\\Aryan\\.ssh\\id_rsa")
  }
}

resource "aws_instance" "hostVMAmazon" {
  instance_type = var.hostInstanceType
  ami           = var.amazonLinuxAMI
  key_name      = aws_key_pair.project1KeyPair.key_name
  tags = {
    Name = "hostVM-Amazon"
  }
  vpc_security_group_ids = [aws_security_group.hostingVMSecGroup.id]
  provisioner "file" {
    source      = "tempHostAmazon.sh"
    destination = "/home/ec2-user/tempHostAmazon.sh"
  }

  provisioner "file" {
    source      = "./html/index.html"
    destination = "/home/ec2-user/index.html"
  }

  provisioner "remote-exec" {
    script = "tempHostAmazon.sh"
  }
  

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("C:\\Users\\Aryan\\.ssh\\id_rsa")
  }
}

# resource "aws_instance" "hostVMs" {
#   # provider      = aws.webIAMuser
#   instance_type = var.hostInstanceType
#   count         = 2
#   ami           = count.index == 0 ? var.ubuntuAMI : var.amazonLinuxAMI
#   key_name      = aws_key_pair.project1KeyPair.key_name
#   tags = {
#     Name = format("hostVM-%d", count.index)
#   }
#   vpc_security_group_ids = [aws_security_group.hostingVMSecGroup.id]

#   provisioner "file" {
#     source      = count.index == 0 ? "./tempHostUbuntu.sh" : ".tempHostAmazon.sh"
#     destination = count.index == 0 ? "/home/ubuntu/templateHostingScript.sh" : "/home/ec2-user/tempHostAmazon.sh"
#   }

#   provisioner "remote-exec" {
#     script = count.index == 0 ? "./tempHostUbuntu.sh" : ".tempHostAmazon.sh"

#   }

#   connection {
#     type        = "ssh"
#     user        = count.index == 0 ? "ubuntu" : "ec2-user"
#     host        = aws_instance.hostVMs[count.index].public_ip
#     private_key = file("C:\\Users\\Aryan\\.ssh\\id_rsa")
#   }

# }
