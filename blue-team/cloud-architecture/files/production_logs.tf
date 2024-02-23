resource "aws_cloudwatch_log_group" "ProductionGroupCloudWatchLogGroup" {
  name = "production-cloudwatch-group"

  tags = {
    Environment = "production"
  }
}

resource "aws_cloudwatch_log_stream" "ProductionGroupCloudWatchLogStream" {
  name = "production-cloudwatch-stream"

  log_group_name = aws_cloudwatch_log_group.ProductionGroupCloudWatchLogGroup.name
}