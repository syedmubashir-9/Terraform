provider "aws" {
    region = "us-east-1"
}


resource "aws_instance" "test"{
    ami = "ami-0453ec754f44f9a4a"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.web.name]

    tags = {
      "name" = "syed"
    }
  

}

# EIP

resource "aws_eip" "test123" {
  instance = aws_instance.test.id
}

# SG


resource "aws_security_group" "web" {
    description = "Allows HTTPS"

    ingress {
        description = "Inbound HTTPS"
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }  

    egress {
        description = "Outbound HTTPS"
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}