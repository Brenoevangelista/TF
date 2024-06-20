#LAMBDA FUNCTIONS
resource "aws_lambda_function" "shared_stop_services" {
  function_name = "${var.prefix}-stop-iac-environment-${var.environment}"
  handler       = "stop_environment.lambda_handler"
  runtime       = "python3.9"
  filename      = "./shared/lambdas/auto_onoff/stop_environment.zip"
  role          = aws_iam_role.lambda_shared_auto_onoff_services.arn

  timeout = 30

  environment {
    variables = {
      LOGGING_LEVEL = "DEBUG"
      DESIRED_COUNT = "0"
    }
  }

  tags = merge(
    var.tags, {
      managed_by  = "terraform"
      owner       = "shared"
      environment = var.environment
  })
}

resource "aws_lambda_function" "shared_start_services" {
  function_name = "${var.prefix}-start-iac-environment-${var.environment}"
  handler       = "start_environment.lambda_handler"
  runtime       = "python3.9"
  filename      = "./shared/lambdas/auto_onoff/start_environment.zip"

  role = aws_iam_role.lambda_shared_auto_onoff_services.arn

  timeout = 30

  environment {
    variables = {
      LOGGING_LEVEL = "DEBUG"
      DESIRED_COUNT = "0"
    }
  }

  tags = merge(
    var.tags, {
      managed_by  = "terraform"
      owner       = "shared"
      environment = var.environment
  })
}


#LAMBDA FUNCTION IAM
resource "aws_iam_role" "lambda_shared_auto_onoff_services" {
  name = "${var.prefix}-auto-onoff-iac-environment-${var.environment}"

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
    "Action": "sts:AssumeRole",
    "Principal": {
        "Service": "lambda.amazonaws.com"
    },
    "Effect": "Allow",
    "Sid": ""
    }
]
}
EOF
}


resource "aws_iam_role_policy_attachment" "lambda_shared_auto_onoff_services_policy_attachment" {
  role       = aws_iam_role.lambda_shared_auto_onoff_services.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_iam_role_policy_attachment" "lambda_shared_auto_onoff_services_ec2_policy_attachment" {
  role       = aws_iam_role.lambda_shared_auto_onoff_services.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_shared_auto_onoff_services_ecs_policy_attachment" {
  role       = aws_iam_role.lambda_shared_auto_onoff_services.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_shared_auto_onoff_services_rds_policy_attachment" {
  role       = aws_iam_role.lambda_shared_auto_onoff_services.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}


#LAMBDA EVENT RULE TRIGGER SETUP
resource "aws_cloudwatch_event_rule" "stop_environment" {
  name                = "${var.prefix}-stop-environment-${var.environment}"
  description         = "Stop resources at 19:00 UTC-3"
  schedule_expression = "cron(0 22 * * ? *)"
}

resource "aws_cloudwatch_event_rule" "start_environment" {
  name                = "${var.prefix}-start-environment-${var.environment}"
  description         = "Start resources at 07:00 UTC-3"
  schedule_expression = "cron(0 10 * * ? *)"
}

resource "aws_cloudwatch_event_target" "stop_environment_event_target" {
  rule      = aws_cloudwatch_event_rule.stop_environment.name
  target_id = aws_lambda_function.shared_stop_services.id
  arn       = aws_lambda_function.shared_stop_services.arn
}

resource "aws_cloudwatch_event_target" "start_environment_event_target" {
  rule      = aws_cloudwatch_event_rule.start_environment.name
  target_id = aws_lambda_function.shared_start_services.id
  arn       = aws_lambda_function.shared_start_services.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_invoke_stop_environemnt" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.shared_stop_services.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_environment.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_invoke_start_environemnt" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.shared_start_services.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_environment.arn
}