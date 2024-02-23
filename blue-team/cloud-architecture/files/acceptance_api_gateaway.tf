resource "aws_apigatewayv2_api" "AcceptanceGroupAPIGateway" {
  name          = "serverless_lambda_gw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "AcceptanceGroupAPIGatewayStage" {
  api_id = aws_apigatewayv2_api.AcceptanceGroupAPIGateway.id

  name        = "serverless_lambda_stage"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.AcceptanceGroupCloudWatchLogGroup.arn

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

resource "aws_apigatewayv2_integration" "AcceptanceGroupAPIGatewayIntegration" {
  api_id = aws_apigatewayv2_api.AcceptanceGroupAPIGateway.id

  integration_uri    = aws_lambda_function.AcceptanceGroupLambdaFunction.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "AcceptanceGroupAPIGatewayRoute" {
  api_id = aws_apigatewayv2_api.AcceptanceGroupAPIGateway.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.AcceptanceGroupAPIGatewayIntegration.id}"
}
