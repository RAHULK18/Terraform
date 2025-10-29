provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "../modules/ec2_instance"
  ami_value = "ami-0c587d11c0a52bfbf" # replace this
  instance_type_value = "t2.micro"
}