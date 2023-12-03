# iam.tf

resource "aws_iam_role" "ssm_role" {
  name = "ssm_role-${var.region}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

variable "iam_policy_arn" {
  description = "IAM Policy to be attached to role"
  type = list(string)
  default = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"]
  
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  role       = "${aws_iam_role.ssm_role.name}"
  count      = "${length(var.iam_policy_arn)}"
  policy_arn = "${var.iam_policy_arn[count.index]}"
}



resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ssm_instance_profile-${var.region}"
  role = aws_iam_role.ssm_role.name
}
