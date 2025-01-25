provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key           
} 


#Defining the Lambda Function
resource "aws_lambda_function" "lambda" {
filename = "lambda_function.zip"
function_name = "myEC2LambdaFunction"
role = "arn:aws:iam::801475100860:role/myrole-243690.58521719"
handler = "lambda_function.lambda_handler"
timeout = 6
runtime = "python3.8"
source_code_hash = filebase64("lambda_function.zip")           
}


