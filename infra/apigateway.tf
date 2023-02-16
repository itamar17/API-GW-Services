resource "aws_api_gateway_rest_api" "poc" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "example"
      version = "1.0"
    }
    paths = {
      "/hello" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${aws_instance.be.public_dns}"
          },
        }
      }
    }
  })

  name = "poc"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "poc" {
  rest_api_id = aws_api_gateway_rest_api.poc.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.poc.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "v1" {
  deployment_id = aws_api_gateway_deployment.poc.id
  rest_api_id   = aws_api_gateway_rest_api.poc.id
  stage_name    = "v1"
}