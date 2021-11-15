
// aws
variable "ami" {
  default = "ami-0279c3b3186e54acd"
}
variable "aws_region" {
  default = "us-east-1"
}

variable "aws_machine_type" {
  default = "t2.micro"
}

variable "ubuntu_password" {
  default = "W3lcome098!!"
}

// RDP Azure

variable "location" {
  default = "East US"
}

variable "admin_password" {
  default = "Password1234"
}

variable "admin_user" {
  default = "adminuser"
}