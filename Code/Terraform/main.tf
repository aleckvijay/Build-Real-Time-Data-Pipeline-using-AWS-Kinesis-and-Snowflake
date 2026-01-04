###############################################
# VARIABLES
###############################################
variable "github_connection_arn" {
  description = "ARN of the AppRunner GitHub connection"
  type        = string
}

variable "repository_url" {
  description = "URL of the GitHub repository"
  type        = string
}

variable "branch_name" {
  description = "Branch to track for auto-deploy"
  type        = string
  default     = "main"
}

###############################################
# Public S3 Bucket for CSV
###############################################

# Step 1: Disable account-level public block
resource "aws_s3_account_public_access_block" "allow_public_access" {
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# Step 2: Create the public bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = "food-data-public-bucket-terraform" # must be globally unique

  tags = {
    Name        = "FoodDataPublicBucket"
    Environment = "dev"
    Purpose     = "Public bucket for FastAPI CSV streaming"
  }
}

# Step 3: Allow bucket-level public access
resource "aws_s3_bucket_public_access_block" "public_bucket_access" {
  bucket = aws_s3_bucket.public_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Step 4: Attach a public read policy
resource "aws_s3_bucket_policy" "public_bucket_policy" {
  bucket = aws_s3_bucket.public_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.public_bucket.arn}/*"
    }]
  })

  # ensure global public block is disabled before applying
  depends_on = [aws_s3_account_public_access_block.allow_public_access]
}

# Step 5: Upload the CSV file
resource "aws_s3_object" "data_upload" {
  bucket = aws_s3_bucket.public_bucket.id
  key    = "total_data.csv"
  source = "${path.module}/upload/total_data.csv"
  etag   = filemd5("${path.module}/upload/total_data.csv")

  depends_on = [aws_s3_bucket_policy.public_bucket_policy]
}

###############################################
# App Runner Service (FastAPI)
###############################################
resource "aws_apprunner_service" "food_api" {
  service_name = "food-streaming-api"

  source_configuration {
    authentication_configuration {
      connection_arn = var.github_connection_arn
    }

    auto_deployments_enabled = true

    code_repository {
      repository_url = var.repository_url
      source_code_version {
        type  = "BRANCH"
        value = var.branch_name
      }
      code_configuration {
        configuration_source = "API"
        code_configuration_values {
          runtime       = "PYTHON_3"
          build_command = "pip install -r requirements.txt"
          start_command = "python app.py"
          port          = "8080"
        }
      }
    }
  }

  instance_configuration {
    cpu    = "2048"
    memory = "4096"
  }

  depends_on = [aws_s3_object.data_upload]
}

###############################################
# Kinesis Stream
###############################################
resource "aws_kinesis_stream" "kinesis_stream" {
  name             = "kinesis-stream"
  retention_period = 24

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }

  tags = {
    Name        = "kinesis-stream"
    Environment = "dev"
    Purpose     = "Real-time data ingestion"
  }

  depends_on = [aws_apprunner_service.food_api]
}

###############################################
# Destination S3 Bucket for Firehose
###############################################
resource "aws_s3_bucket" "destination_bucket" {
  bucket = "new-terraform-project-s3-kinesis"

  tags = {
    Name        = "DestinationBucket"
    Environment = "dev"
    Purpose     = "Kinesis Firehose output"
  }

  depends_on = [aws_kinesis_stream.kinesis_stream]
}

###############################################
# Lambda Function + Role
###############################################
resource "aws_iam_role" "lambda_role" {
  name = "lambda_kinesis_firehose_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  depends_on = [aws_s3_bucket.destination_bucket]
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_s3_access" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy" "lambda_cloudwatch_logs" {
  name = "lambda_cloudwatch_logs"
  role = aws_iam_role.lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["logs:CreateLogGroup","logs:CreateLogStream","logs:PutLogEvents"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function" "convert_to_CSV_snowflake" {
  function_name = "convert_to_CSV_snowflake"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  filename      = "${path.module}/lambda_function.zip"
  memory_size   = 512
  timeout       = 600

  depends_on = [aws_iam_role_policy.lambda_cloudwatch_logs]
}

###############################################
# Kinesis Firehose IAM Role
###############################################
resource "aws_iam_role" "firehose_role" {
  name = "firehose_s3_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "firehose.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  depends_on = [aws_lambda_function.convert_to_CSV_snowflake]
}

resource "aws_iam_role_policy_attachment" "firehose_s3_access" {
  role       = aws_iam_role.firehose_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "firehose_lambda_access" {
  role       = aws_iam_role.firehose_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_iam_role_policy_attachment" "firehose_cloudwatch_access" {
  role       = aws_iam_role.firehose_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

resource "aws_iam_role_policy" "firehose_kinesis_stream_access" {
  name = "firehose_kinesis_stream_access"
  role = aws_iam_role.firehose_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow"
      Action = [
        "kinesis:DescribeStream",
        "kinesis:GetShardIterator",
        "kinesis:GetRecords",
        "kinesis:ListShards",
        "kinesis:DescribeStreamSummary"
      ]
      Resource = aws_kinesis_stream.kinesis_stream.arn
    }]
  })
}

###############################################
# Kinesis Firehose Delivery Stream
###############################################
resource "aws_kinesis_firehose_delivery_stream" "kinesis_firehose_csv" {
  name        = "kinesis_firehose"
  destination = "extended_s3"

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.kinesis_stream.arn
    role_arn           = aws_iam_role.firehose_role.arn
  }

  extended_s3_configuration {
    role_arn                      = aws_iam_role.firehose_role.arn
    bucket_arn                    = aws_s3_bucket.public_bucket.arn
    prefix                        = "data/"
    compression_format             = "UNCOMPRESSED"
    buffering_size         = 3
    buffering_interval  = 900

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = "/aws/kinesisfirehose/kinesis_firehose_csv"
      log_stream_name = "S3Delivery"
    }

    processing_configuration {
      enabled = true
      processors {
        type = "Lambda"
        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = aws_lambda_function.convert_to_CSV_snowflake.arn
        }
        parameters {
          parameter_name  = "NumberOfRetries"
          parameter_value = "3"
        }
        parameters {
          parameter_name  = "RoleArn"
          parameter_value = aws_iam_role.firehose_role.arn
        }
      }
    }
  }

  tags = {
    Name        = "kinesis_firehose_csv"
    Environment = "dev"
    Purpose     = "Transform and deliver Kinesis data to S3 via Lambda"
  }

  depends_on = [aws_iam_role_policy.firehose_kinesis_stream_access]
}


