# Defining the provider

provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
  
}

#Creating the SG for the instance
resource "aws_security_group" "EC2SG" {
  name = "EC2-SG"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Now defining the EC2 instance 

resource "aws_instance" "ec2instance" {
  ami              = "ami-0c101f26f147fa7fd"
  instance_type    = "t2.micro"
  security_groups  = ["${aws_security_group.EC2SG.name}"] 
  # ["${aws_security_group.ec2sg.name}"] represents a list containing the name of the security group.
  


 
# Passing the instance initialization script to install the apache server and add a html page.

  user_data = <<-EOF
    #!/bin/bash
    sudo su
    yum update -y
    yum install httpd -y
    echo "<html><h1> Hello from AWS </h1></html>" >> /var/www/html/index.html  
    systemctl start httpd
    systemctl enable httpd
  EOF

  tags = {
    Name = "EC2Server"
  }
}

# Now creating an AMI of the new instance

resource "aws_ami_from_instance" "ec2ami" {
  name               = "MyEC2Image"
  source_instance_id = aws_instance.ec2instance.id
  # "aws_instance.ec2instance.id" fetches the unique instance ID of the EC2 instance created by the aws_instance resource.
  

}







