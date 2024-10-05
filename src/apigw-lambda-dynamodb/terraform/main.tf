module "dynamodb" {
  source = "./modules/dynamodb"
  prefix = "test"
}

module "iam" {
  source = "./modules/iam"
  prefix = "test"
  user_table-arn = module.dynamodb.user_table.arn
}
