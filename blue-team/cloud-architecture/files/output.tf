output "test_rds_hostname" {
  description = "Test: RDS instance hostname"
  value       = aws_db_instance.TestGroupDatabase.address
  sensitive   = true
}

output "test_rds_port" {
  description = "Test: RDS instance port"
  value       = aws_db_instance.TestGroupDatabase.port
  sensitive   = true
}

output "test_rds_username" {
  description = "Test: RDS instance root username"
  value       = aws_db_instance.TestGroupDatabase.username
  sensitive   = true
}

output "test_function_name" {
  description = "Test: Name of the Lambda function."

  value = aws_lambda_function.TestGroupLambdaFunction.function_name
}

output "test_base_url" {
  description = "Test: Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.TestGroupApiGatewayStage.execution_arn
}

/// ACCEPTANCE PART ///

output "acceptance_rds_hostname" {
  description = "Acceptance: RDS instance hostname"
  value       = aws_db_instance.AcceptanceGroupDatabase.address
  sensitive   = true
}

output "acceptance_rds_port" {
  description = "Acceptance: RDS instance port"
  value       = aws_db_instance.AcceptanceGroupDatabase.port
  sensitive   = true
}

output "acceptance_rds_username" {
  description = "Acceptance: RDS instance root username"
  value       = aws_db_instance.AcceptanceGroupDatabase.username
  sensitive   = true
}

output "acceptance_function_name" {
  description = "Acceptance: Name of the Lambda function."

  value = aws_lambda_function.AcceptanceGroupLambdaFunction.function_name
}

output "acceptance_base_url" {
  description = "Acceptance: Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.AcceptanceGroupAPIGatewayStage.execution_arn
}

/// INTERNAL GROUP ///

output "internal_aurora_endpoint" {
  description = "Internal: AURORA instance hostname"
  value       = aws_rds_cluster.InternalGroupAuroraCluster.endpoint
  sensitive   = true
}

output "internal_aurora_port" {
  description = "Internal: AURORA instance port"
  value       = aws_rds_cluster.InternalGroupAuroraCluster.port
  sensitive   = true
}

/// PRODUCTION GROUP ///

output "production_rds_hostname" {
  description = "Prod: RDS instance hostname"
  value       = aws_db_instance.ProductionGroupDatabase.address
  sensitive   = true
}

output "production_rds_port" {
  description = "Prod: RDS instance port"
  value       = aws_db_instance.ProductionGroupDatabase.port
  sensitive   = true
}

output "production_rds_username" {
  description = "Prod: RDS instance root username"
  value       = aws_db_instance.ProductionGroupDatabase.username
  sensitive   = true
}

output "production_function_name" {
  description = "Prod: Name of the Lambda function."

  value = aws_lambda_function.ProductionGroupLambdaFunction.function_name
}

output "production_base_url" {
  description = "Prod: Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.ProductionGroupApiGatewayStage.execution_arn
}