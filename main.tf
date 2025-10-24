provider "aws" {
      region = "us-west-2"
      profile = "terraform-personal"
}

resource "aws_instance" "terraform-ec2" {
      ami ="ami-0e1d35993cb249cee"
      instance_type = "t2.micro"
}


