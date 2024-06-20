# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "lead-score-api_log_group" {
  name              = "/ecs/lead-score-api"
  retention_in_days = 3

  tags = {
    Name = "lead-score-api-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "lead-score-api_log_stream" {
  name           = "lead-score-api-log-stream"
  log_group_name = aws_cloudwatch_log_group.lead-score-api_log_group.name
}