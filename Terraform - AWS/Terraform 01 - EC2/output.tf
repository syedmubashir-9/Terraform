# Defining the output variable
output "ami_id" {
  value = aws_ami_from_instance.ec2ami.id
}
