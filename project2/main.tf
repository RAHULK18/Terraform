#create key pair
resource "aws_key_pair" "demo-key" {
  key_name = "terraform-demo-rahul"
  public_key = file("/Users/rahulkarmakar/Desktop/terraform-demo.pub")
}

#create vpc 
resource "aws_vpc" "demo-vpc" {
  cidr_block = var.cidr
  tags = {
    Name = "project-demo"
  }
}

#creare subnet1
resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-west-2c"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "project-demosub1"
  }
}

#creare subnet1
resource "aws_subnet" "sub2" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "project-demosub2"
  }
}

#creare igw
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "project-demo"
  }
}

#creare route table
resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.demo-vpc.id
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gw.id

    }
    tags = {
    Name = "project-demo"
  }
    
  }
#creare route table association with subnet
  resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.RT.id
}

#create security group with ingress and egress
resource "aws_security_group" "demosg" {
  name        = "demo-sg"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.demo-vpc.id

  tags = {
    Name = "Demo-sg"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv41" {
  security_group_id = aws_security_group.demosg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv42" {
  security_group_id = aws_security_group.demosg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv43" {
  security_group_id = aws_security_group.demosg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

#create s3 bucket
resource "aws_s3_bucket" "demo" {
  bucket = "2025-rahul-projet-demo"

  tags = {
    Name        = "2025-rahul-projet-demo"
    Environment = "prod"
  }
}

# enable s3 bucket ownership control 
resource "aws_s3_bucket_ownership_controls" "bucketcontrol" {
  bucket = aws_s3_bucket.demo.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
# enable s3 bucket acl 
resource "aws_s3_bucket_acl" "demoacl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucketcontrol]

  bucket = aws_s3_bucket.demo.id
  acl    = "private"
}

#create ec2 instance
resource "aws_instance" "demo-web1" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.demosg.id]
  subnet_id = aws_subnet.sub1.id
  key_name = aws_key_pair.demo-key.id
  user_data = file("user_data.sh")
  tags = {
    Name = "Web-Server-1"
  }

}

resource "aws_instance" "demo-web2" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.demosg.id]
  subnet_id = aws_subnet.sub2.id
  key_name = aws_key_pair.demo-key.id
  user_data = file("user_data1.sh")
  tags = {
    Name = "Web-Server-2"
  }

}



