data "template_file" "openapi-schema" {
  template = file("scripts/openapi.json")
    vars     = {
      URL = "http://${aws_instance.be.public_dns}"
    }
}

resource "aws_api_gateway_rest_api" "poc" {
  body = data.template_file.openapi-schema.rendered
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

resource "aws_api_gateway_stage" "dev" {
  deployment_id = aws_api_gateway_deployment.poc.id
  rest_api_id   = aws_api_gateway_rest_api.poc.id
  stage_name    = "dev"
}