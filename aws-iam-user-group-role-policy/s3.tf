resource "aws_s3_bucket" "terraform-bucket-test" {
  bucket = "terraform-bucket-test-2"
}

resource "aws_s3_bucket_acl" "terraform-bucket-test_acl" {
  bucket = aws_s3_bucket.terraform-bucket-test.id
  acl    = "private"
  depends_on = [aws_iam_role_policy.s3-role-policy, aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]  # Add a dependency on the IAM role policy
}

# Error: creating S3 Bucket (terraform-bucket-test-2) ACL: operation error S3: PutBucketAcl, https response error StatusCode: 400, RequestID: F4A521160990DJZB, HostID: qa6Vmlnebdrwa6wF3ihLgnVfq0tC7dwdzHTMcUcHTBFKaTTjcg11ohOgB6WL+qGAHKyXvS2y5kLmh68enNhRAA==, api error AccessControlListNotSupported: The bucket does not allow ACLs

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.terraform-bucket-test.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

# Output the bucket name 
output "bucket_name" {
  value = aws_s3_bucket.terraform-bucket-test.bucket
}
