# Following steps will be performed
# Define IAM User and Groups

resource "aws_iam_user" "iam_user_01" {
  name="iam_user_01"
}

resource "aws_iam_user" "iam_user_02" {
  name="iam_user_02"
}

resource "aws_iam_group" "iam_group_01" {
  name="iam_group_01"
}
# Assign the user to the created group

resource "aws_iam_group_membership" "attach_users" {
    name = "group_users"
    users = [aws_iam_user.iam_user_01.name, aws_iam_user.iam_user_02.name]
    group = aws_iam_group.iam_group_01.name

}
# Attached policy to the group
resource "aws_iam_policy_attachment" "attach_policy"{
    name = "attach_policy"
    groups = [aws_iam_group.iam_group_01.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" # this will give full access to s3 to the group so that all users in the group will have access to S3
}