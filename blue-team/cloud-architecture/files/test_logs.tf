resource "aws_cloudwatch_log_group" "TestGroupCloudWatchLogGroup" {
  name = "Test-cloudwatch-group"

  tags = {
    Environment = "Test"
  }
}

resource "aws_cloudwatch_log_stream" "TestGroupCloudWatchLogStream" {
  name           = "Test-cloudwatch-stream"

  log_group_name = aws_cloudwatch_log_group.TestGroupCloudWatchLogGroup.name
}
