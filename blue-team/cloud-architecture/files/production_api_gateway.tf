resource "aws_apigatewayv2_api" "ProductionGroupApiGateway" {
  name          = "serverless_lambda_gw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "ProductionGroupApiGatewayStage" {
  api_id = aws_apigatewayv2_api.ProductionGroupApiGateway.id

  name        = "serverless_lambda_stage"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.ProductionGroupCloudWatchLogGroup.arn

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

resource "aws_apigatewayv2_integration" "ProductionGroupApiGatewayIntegration" {
  api_id = aws_apigatewayv2_api.ProductionGroupApiGateway.id

  integration_uri    = aws_lambda_function.ProductionGroupLambdaFunction.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "ProductionGroupApiGatewayRoute" {
  api_id = aws_apigatewayv2_api.ProductionGroupApiGateway.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.ProductionGroupApiGatewayIntegration.id}"
}

resource "aws_lambda_permission" "ProductionGroupApiGatewayPermission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ProductionGroupLambdaFunction.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.ProductionGroupApiGateway.execution_arn}/*/*"
}