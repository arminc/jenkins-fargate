resource "aws_ecs_cluster" "jenkins" {
  name = "${var.cluster}"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.environment}_ecs_task_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ecs-tasks.amazonaws.com"
        ]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ecs_task_execution_role" {
  name = "${var.environment}_ecs_task_execution_role"
  role = "${aws_iam_role.ecs_task_execution_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
      ],
      "Resource": ["*"]
    }
  ]
}
EOF
}