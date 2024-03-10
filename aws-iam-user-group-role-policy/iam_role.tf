# Create a role to access to s3 bucket
resource "aws_iam_role" "s3-role" {
  name = "s3-role"
  assume_role_policy = "${file("assume_role_policy.json")}"
  depends_on = [ aws_s3_bucket.terraform-bucket-test ]
}

# Create a policy to attact to a role
resource "aws_iam_role_policy" "s3-role-policy" {
  name = "s3-role-ploicy"
  role = aws_iam_role.s3-role.name
  policy = "${file("s3_role_policy.json")}"

  # Add a dependency on the IAM role creation
  depends_on = [aws_iam_role.s3-role]
}

# intance profile arm

resource "aws_iam_instance_profile" "s3-role-instance-profile" {
  name = "s3-role-instance-profile"
  role = aws_iam_role.s3-role.name
}

