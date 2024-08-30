resource "aws_iam_instance_profile" "this" {
  name = "JenkinsProfile"
  role = aws_iam_role.this.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  name               = "JenkinsRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
