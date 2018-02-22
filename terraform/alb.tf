resource "aws_alb_target_group" "http" {
  name                 = "${var.environment}-default-http"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = "${aws_vpc.vpc.id}"
  deregistration_delay = "${var.deregistration_delay}"
  target_type          = "ip"

  health_check {
    interval            = "${var.http_health_check_interval}"
    path                = "${var.http_health_check_path}"
    port                = "${var.http_health_check_port}"
    protocol            = "${var.http_health_check_protocol}"
    timeout             = "${var.http_health_check_timeout}"
    healthy_threshold   = "${var.http_health_check_healthy_threshold}"
    unhealthy_threshold = "${var.http_health_check_unhealthy_threshold}"
    matcher             = "${var.http_health_check_matcher}"
  }

  tags {
    Environment = "${var.environment}"
  }
}

resource "aws_alb" "alb" {
  name            = "${var.environment}"
  subnets         = ["${aws_subnet.public_subnet.*.id}"]
  security_groups = ["${aws_security_group.alb.id}"]

  tags {
    Environment = "${var.environment}"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.alb.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.http.id}"
    type             = "forward"
  }
}

resource "aws_security_group" "alb" {
  name   = "${var.environment}_alb"
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb.id}"
  description       = "Open to the internet"
}

resource "aws_security_group_rule" "outbound_internet_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.alb.id}"
}
