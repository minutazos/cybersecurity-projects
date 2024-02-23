resource "aws_cloudwatch_log_group" "InternalGroupCloudWatchLogGroup" {
  name = "internal-cloudwatch-group"

  tags = {
    Environment = "internal"
  }
}

resource "aws_cloudwatch_log_stream" "InternalGroupCloudWatchLogStream" {
  name           = "internal-cloudwatch-stream"

  log_group_name = aws_cloudwatch_log_group.InternalGroupCloudWatchLogGroup.name
}
