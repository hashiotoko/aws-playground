module "dynamodb" {
  source = "./modules/dynamodb"
  name_prefix = "test"
}

module "iam" {
  source = "./modules/iam"
  name_prefix = "test"
  user_table-arn = module.dynamodb.user_table.arn
}

module "lambda" {
  source = "./modules/lambda"
  name_prefix = "test"
  user_table-name = module.dynamodb.user_table.name
  user_table-hash_key = module.dynamodb.user_table.hash_key
  lambda_dynamodb_role-arn = module.iam.lambda_role-arn
}
