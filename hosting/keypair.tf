resource "aws_key_pair" "project1KeyPair" {
  key_name   = "project1keypair"
  public_key = file("C:\\Users\\Aryan\\.ssh\\id_rsa.pub")
}