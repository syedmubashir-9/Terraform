provider "aws" {
    region     = var.region   
    access_key = var.access_key
    secret_key = var.secret_key
}


################## Creating an EKS Cluster ##################
resource "aws_eks_cluster" "cluster" {
  name     = "lab"
  role_arn = "arn:aws:iam::034278417477:role/task98_role_243690.13925752"

  vpc_config {
    subnet_ids = ["subnet-03cb0609cc7f6d15c", "subnet-0353fbe94adda0697"]
  }
}