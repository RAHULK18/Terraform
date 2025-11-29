#key pair

resource "aws_key_pair" "rk-key" {
    key_name = "terraform-rk-key-ec2"
    public_key = file("/Users/rahulkarmakar/Desktop/terraform-demo.pub")

}

#vpc

resource "aws_vpc" "rk-vpc" {
     cidr_block = "10.0.0.0/16"
    tags = {
      Name = "rk-vpc"
    }
}

resource "aws_subnet" "rk-subnet" {
     vpc_id = aws_vpc.rk-vpc.id
     cidr_block = "10.0.1.0/24"
     availability_zone = var.ec2_az
    map_public_ip_on_launch = true
    tags = {
      Name = "rk-subnet"
    }
}

resource "aws_internet_gateway" "rk-igw" {
  vpc_id = aws_vpc.rk-vpc.id
  tags = {
    Name = "rk-igw"
  }
}

resource "aws_route_table" "rt-rk" {
  vpc_id = aws_vpc.rk-vpc.id


  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.rk-igw.id

    }
}
resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.rk-subnet.id
  route_table_id = aws_route_table.rt-rk.id
}



resource "aws_security_group" "rk-sg" {
  name = "automate-sg"
  description = "tf generated sg"
  vpc_id = aws_vpc.rk-vpc.id

  tags = {
 Name =  "automate-sg"
  }
  ingress {
     from_port = 22
     to_port = 22
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
     description = "SSH"

  }
  ingress {
     from_port = 80
     to_port = 80
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
     description = "HTTP"

  }

  egress  {
     from_port = 0
     to_port = 0
     protocol = "-1"
     cidr_blocks = ["0.0.0.0/0"]
     description = "All"
  }
}


resource "aws_instance" "rk-ec2" {
  #count = 2 #meta arguement
  for_each = tomap(
    {
      rk-micro = "t2.micro"
      rk-medium = "t2.medium"
      rk-micro2 = "t2.micro"
      
    }
  )
  depends_on = [ aws_security_group.rk-sg ]
  ami = var.ec2_ami_id #interpolation
  instance_type = each.value
  availability_zone = var.ec2_az
  key_name = aws_key_pair.rk-key.id
  subnet_id = aws_subnet.rk-subnet.id
  vpc_security_group_ids = [aws_security_group.rk-sg.id]  
  user_data = file("user_data.sh")
  root_block_device {
    volume_size = var.env == "prd" ? 20 : var.ec2_root_block_size #conditional
    volume_type = "gp3"
  }

 tags = {
    Name = each.key
    
 }  
}

/*resource "aws_instance" "my_new_ec2" {
    ami = "unknown"
    instance_type =  "unknown"
}*/