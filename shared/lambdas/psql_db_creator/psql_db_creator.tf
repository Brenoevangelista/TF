#LAMBDA FUNCTIONS
resource "aws_lambda_function" "shared_psql_db_creator" {
  function_name = "${var.prefix}-shared-psql-db-creator-${var.environment}"
  handler       = "lambda_psql_db_creator.lambda_handler"
  runtime       = "python3.9"
  filename      = "./shared/lambdas/psql_db_creator/lambda_psql_db_creator.zip"
  role          = aws_iam_role.shared_psql_db_creator.arn

  timeout = 30

  environment {
    variables = {
      APP_NAME            = ""
      DESIRED_DB_NAME     = ""
      ENVIRONMENT         = var.environment
      TARGET_PSQL_DB_HOST = var.shared_psql_db_instance_endpoint
      LOGGING_LEVEL       = "DEBUG"
    }
  }

  vpc_config {
    subnet_ids         = var.vpc_private_subnets_ids
    security_group_ids = [aws_security_group.shared_psql_db_creator.id]
  }

  tags = merge(
    var.tags, {
      managed_by  = "terraform"
      owner       = "shared"
      environment = var.environment
  })
}

#LAMBDA SECURITY
resource "aws_security_group" "shared_psql_db_creator" {
  vpc_id = var.vpc_id
  name   = "${var.prefix}-shared-psql-db-creator-${var.environment}"

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags, {
      managed_by  = "terraform"
      owner       = "shared"
      environment = var.environment
  })
}

#LAMBDA FUNCTION IAM
resource "aws_iam_role" "shared_psql_db_creator" {
  name = "${var.prefix}-shared-psql-db-creator-role-${var.environment}"

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

resource "aws_iam_policy" "shared_psql_db_creator_policy" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameter",
        "kms:Decrypt"
      ],
      "Resource": [        
        "arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:parameter/*",
        "arn:aws:kms:${var.aws_region}:${var.aws_account_id}:key/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "shared_psql_db_creator_policy_attachment" {
  role       = aws_iam_role.shared_psql_db_creator.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_iam_role_policy_attachment" "lambda_shared_psql_db_creator_ec2_policy_attachment" {
  role       = aws_iam_role.shared_psql_db_creator.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_shared_psql_db_creator_rds_policy_attachment" {
  role       = aws_iam_role.shared_psql_db_creator.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}


resource "aws_iam_role_policy_attachment" "lambda_shared_psql_db_creator_ssm_policy_attachment" {
  role       = aws_iam_role.shared_psql_db_creator.name
  policy_arn = aws_iam_policy.shared_psql_db_creator_policy.arn
}