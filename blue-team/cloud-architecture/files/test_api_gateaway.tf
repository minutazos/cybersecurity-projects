resource "aws_apigatewayv2_api" "TestGroupApiGateway" {
  name          = "serverless_lambda_gw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "TestGroupApiGatewayStage" {
  api_id = aws_apigatewayv2_api.TestGroupApiGateway.id

  name        = "serverless_lambda_stage"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.TestGroupCloudWatchLogGroup.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
    }
    )
  }
}

resource "aws_apigatewayv2_integration" "TestGroupApiGatewayIntegration" {
  api_id = aws_apigatewayv2_api.TestGroupApiGateway.id

  integration_uri    = aws_lambda_function.TestGroupLambdaFunction.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "TestGroupApiGatewayRoute" {
  api_id = aws_apigatewayv2_api.TestGroupApiGateway.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.TestGroupApiGatewayIntegration.id}"
}

resource "aws_lambda_permission" "TestGroupApiGatewayPermission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.TestGroupLambdaFunction.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.TestGroupApiGateway.execution_arn}/*/*"
}