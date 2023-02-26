data "template_file" "openapi-schema" {
  template = file("scripts/openapi.json")
  vars     = {
    URL = "http://${aws_lb.alb.dns_name}"
  }
}

resource "aws_api_gateway_rest_api" "poc" {
  // Setting the extended merged OpenAPI schema of the micro-services as input
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
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.apigw_access_logs.arn
    format          = "$context.identity.sourceIp $context.identity.caller  $context.identity.user [$context.requestTime] $context.httpMethod $context.resourcePath $context.protocol $context.status $context.responseLength $context.requestId $context.extendedRequestId"
  }
  cache_cluster_enabled = true
  cache_cluster_size = "0.5"
}

// Enabling logging
resource "aws_api_gateway_account" "demo" {
  cloudwatch_role_arn = aws_iam_role.cloudwatch.arn
}

resource "aws_cloudwatch_log_group" "apigw_access_logs" {
  name = "apigw_access_logs"
}

resource "aws_iam_role" "cloudwatch" {
  name               = "api_gateway_cloudwatch_global"
  assume_role_policy = file("policies/apigateway-role.json")
}

resource "aws_iam_role_policy" "cloudwatch" {
  name   = "default"
  role   = aws_iam_role.cloudwatch.id
  policy = file("policies/apigateway-cloudwatch-policy.json")
}

resource "aws_api_gateway_method_settings" "general_settings" {
  rest_api_id = aws_api_gateway_rest_api.poc.id
  stage_name  = aws_api_gateway_stage.dev.stage_name
  method_path = "*/*"

  settings {
    # Enable CloudWatch logging and metrics
    metrics_enabled        = true
    data_trace_enabled     = true
    logging_level          = "INFO"
    # Limit the rate of calls to prevent abuse and unwanted charges
    throttling_rate_limit  = 1
    throttling_burst_limit = 2

    // TODO: caching is also defined here
    caching_enabled = true
    cache_ttl_in_seconds = 5
  }
}