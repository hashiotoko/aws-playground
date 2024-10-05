variable "prefix" {
  type = string
}

resource "aws_dynamodb_table" "user" {
  name = "${var.prefix}_user"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "UserId"
  attribute {
    name = "UserId"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "user_item" {
  table_name = aws_dynamodb_table.user.name
  hash_key = aws_dynamodb_table.user.hash_key
  item = jsonencode({
    UserId = {
      S = "1"
    },
    FirstName = {
      S = "Taro"
    },
    LastName = {
      S = "Tanaka"
    }
  })
}

output "user_table" {
  value = aws_dynamodb_table.user
}
