variable "name_prefix" {
  type = string
}

variable "lambda-invoke-arn" {
  type = string
}

variable "allow-ips" {
  type      = set(string)
  sensitive = true
}

resource "aws_api_gateway_rest_api" "api" {
  name = "${var.name_prefix}-api"
}

resource "aws_api_gateway_resource" "api_resource_id" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "api_get" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.api_resource_id.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_get" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  http_method             = aws_api_gateway_method.api_get.http_method
  resource_id             = aws_api_gateway_resource.api_resource_id.id
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda-invoke-arn
}

data "aws_iam_policy_document" "api_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    resources = ["${aws_api_gateway_rest_api.api.execution_arn}/*"]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = var.allow-ips
    }
  }
}
resource "aws_api_gateway_rest_api_policy" "test" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  policy      = data.aws_iam_policy_document.api_policy.json
}

resource "aws_api_gateway_deployment" "api" {
  depends_on  = [aws_api_gateway_integration.api_get]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "test"
  triggers = {
    redeployment = filebase64("${path.module}/api-gateway.tf")
  }
}

output "api-execution-role" {
  value = aws_api_gateway_rest_api.api.execution_arn
}
