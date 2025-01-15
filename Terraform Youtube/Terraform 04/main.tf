provider "aws" {
    region = "us-east-1"
  
}


resource "aws_instance" "test123" {

    ami = "ami-0d0e8b294f5fa3e60"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.test123_sg.name]
    key_name = aws_key_pair.demo.key_name

    tags = {
      "name" = "syed"
    }

  
}

resource "aws_eip" "test123_eip" {

    instance = aws_instance.test123.id
  
}

resource "aws_security_group" "test123_sg" {

    name = "Allow HTTPS"

    ingress {
        description = "Inbound HTTPS"
        from_port = 0
        to_port = 6556
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }  

    egress {
        description = "Outbound HTTPS"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}


resource "aws_key_pair" "demo" {
    key_name = "demo_aws"
    public_key = file("key/demo key.pub")
}


output "eip" {

    value = aws_eip.test123_eip.public_ip
  
}