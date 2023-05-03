variable "seckey" {
  type  = string
  default = "X919aYbeH1euzjik9DMCet3c+RsGUA63t+eQWwKA"
  description = "secret key"
}

variable "acckey" {
  type  = string
  default = "AKIAXB67BCSUOJKE3D4L"
  description = "access key"
}

variable "cloudRegion" {
  type  = string
  default = "us-east-1"
  description = "region"
}

variable "hostInstanceType" {
  type = string
  default = "t2.micro"
  description = "instance_type t2.micro"
}

variable "ubuntuAMI" {
  type = string
  default = "ami-007855ac798b5175e"
  description = "ubuntu ami id"
}

variable "amazonLinuxAMI" {
  type = string
  default = "ami-02396cdd13e9a1257"
  description = "ubuntu ami id"
}