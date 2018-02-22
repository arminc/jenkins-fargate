resource "aws_ecs_task_definition" "jenkins" {
  family                   = "jenkins"
  container_definitions    = "${file("jenkins.json")}"
  execution_role_arn       = "${aws_iam_role.ecs_task_execution_role.arn}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
}

resource "aws_ecs_service" "jenkins" {
  name            = "jenkins"
  cluster         = "${aws_ecs_cluster.jenkins.id}"
  task_definition = "${aws_ecs_task_definition.jenkins.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["${aws_subnet.private_subnet.*.id}"]
    security_groups  = []
    assign_public_ip = "false"
  }
}

resource "aws_cloudwatch_log_group" "jenkins" {
  name              = "jenkins"
  retention_in_days = 7
}