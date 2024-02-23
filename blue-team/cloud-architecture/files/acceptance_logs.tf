resource "aws_cloudwatch_log_group" "AcceptanceGroupCloudWatchLogGroup" {
  name = "Acceptance-cloudwatch-group"

  tags = {
    Environment = "Acceptance"
  }
}

resource "aws_cloudwatch_log_stream" "AcceptanceGroupCloudWatchLogStream" {
  name           = "Acceptance-cloudwatch-stream"

  log_group_name = aws_cloudwatch_log_group.AcceptanceGroupCloudWatchLogGroup.name
}
