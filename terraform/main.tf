
resource "aws_s3_bucket" "venky-first-bucket" {
  bucket = "${var.bucket-env-prefix}-venky-s3-first-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

