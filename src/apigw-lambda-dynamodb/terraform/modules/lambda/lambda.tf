variable "name_prefix" {
  type = string
}

variable "user_table-name" {
  type = string
}

variable "user_table-hash_key" {
  type = string
}

variable "lambda_dynamodb_role-arn" {
  type = string
}

variable "api-execution-arn" {
  type = string
}

data "archive_file" "lambda_layer" {
  type = "zip"
  source_dir = "./dist/lambda_layer"
  output_path = "./output/lambda_layer.zip"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name = "node_modules-leyer"
  filename = data.archive_file.lambda_layer.output_path
  source_code_hash = data.archive_file.lambda_layer.output_base64sha256
  compatible_runtimes = ["nodejs18.x"]
}

data "archive_file" "lambda_function" {
  type = "zip"
  source_file = "./dist/lambda.js"
  output_path = "./output/lambda_func.zip"
}


resource "aws_lambda_function" "lambda" {
  filename = data.archive_file.lambda_function.output_path
  function_name = "${var.name_prefix}_lambda"
  role = var.lambda_dynamodb_role-arn
  handler = "lambda.handler"
  source_code_hash = data.archive_file.lambda_function.output_base64sha256
  runtime = "nodejs18.x"
  layers = [aws_lambda_layer_version.lambda_layer.arn]
  timeout = 29
  environment {
    variables = {
      TABLE_NAME = var.user_table-name
      PRIMARY_KEY = var.user_table-hash_key
    }
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowAPIGatewayGetApi"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal = "apigateway.amazonaws.com"
  source_arn = "${var.api-execution-arn}/*"
}

output "lambda-invoke-arn" {
  value = aws_lambda_function.lambda.invoke_arn
}
