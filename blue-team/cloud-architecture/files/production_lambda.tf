resource "aws_lambda_function" "ProductionGroupLambdaFunction" {
  filename      = "./lambda/lambda.zip"
  function_name = "lambda_function_production"
  role          = aws_iam_role.TestIAMRole.arn
  handler       = "textLambda.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("./lambda/lambda.zip")

  runtime       = "nodejs16.x"

  environment {
    variables = {
      "ENV_NAME" = "Production"
    }
  }
}