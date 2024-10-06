module "dynamodb" {
  source = "./modules/dynamodb"
  name_prefix = "test"
}

module "iam" {
  source = "./modules/iam"
  name_prefix = "test"
  user_table-arn = module.dynamodb.user_table.arn
}
