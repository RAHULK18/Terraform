provider "aws" {
  region = "us-west-2"
  profile = "terraform-personal"
}
variable "ami" {

  description = "This is the ami"
}
variable "instance_type" {
  description = "This is the instance type"
}

resource "aws_instance" "example" {
  ami = var.ami
  instance_type = var.instance_type
}