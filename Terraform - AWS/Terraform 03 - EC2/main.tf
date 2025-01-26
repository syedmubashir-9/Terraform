provider "aws"  {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}


#Creating a key pair

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "labkey" {
  key_name   = "lab-key"
  public_key = tls_private_key.example.public_key_openssh
}

############ Creating a cloudformation stack ############
resource "aws_cloudformation_stack" "labstack" {
  parameters = {
    DBName= "MyDatabase"
    DBPassword = "labsdb123"
    DBRootPassword ="labsdbroot123"
    DBUser = "labsDBUser"
    InstanceType="t2.micro"
  }
  name = "lab-stack"
  template_body = file("LAMP_template.json")
}