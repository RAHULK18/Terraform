variable "ec2_aws_instance_type" {
  default = "t2.micro"
  type = string
}

variable "ec2_root_block_size" {
  default = "10"
  type = number
}

variable "ec2_ami_id" {
  default = "ami-00f46ccd1cbfb363e"
  type = string
}
variable "ec2_az" {
  default = "us-west-2c"
  type = string
}


variable "env" {
  default = "dev"
  type = string

}