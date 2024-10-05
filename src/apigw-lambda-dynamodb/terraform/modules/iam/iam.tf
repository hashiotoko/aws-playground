variable "prefix" {
  type = string
}

variable "user_table-arn" {
  type = string
}

resource "aws_iam_role" "lambda-dynamodb-role" {
  name = "${var.prefix}-lambda-dynamo-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda-dynamodb-role-policy-attach" {
  role = aws_iam_role.lambda-dynamodb-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "dynamodb-read-policy" {
  name = "${var.prefix}-dynamodb-read-policy"
  role = aws_iam_role.lambda-dynamodb-role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem"
        ]
        Resource = [
          var.user_table-arn
        ]
      }
    ]
  })
}

output "tr_lambda_role-arn" {
  value = aws_iam_role.lambda-dynamodb-role.arn
}
