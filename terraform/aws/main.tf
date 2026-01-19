provider "aws" {
  region = var.region
}

# -----------------------------
# CloudTrail (Prevents AP-003)
# -----------------------------
resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = "cloudtrail-security-baseline-${var.account_id}"
}

resource "aws_cloudtrail" "org_trail" {
  name                          = "security-baseline-trail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true
}

# -----------------------------
# IAM Password Policy (Mitigates AP-001)
# -----------------------------
resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 14
  require_uppercase_characters  = true
  require_lowercase_characters  = true
  require_numbers               = true
  require_symbols               = true
  allow_users_to_change_password = true
}

# -----------------------------
# Guardrail: Deny Public S3 (Mitigates AP-002)
# -----------------------------
resource "aws_s3_account_public_access_block" "block_public" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
