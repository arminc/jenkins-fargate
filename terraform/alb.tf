module "jenkins_http" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "v1.19.0"

  name        = "jenkins-alb-sg"
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "alb" {
  source  = "github.com/terraform-aws-modules/terraform-aws-alb" //Does not work with target_type ip, only master works "terraform-aws-modules/alb/aws"

  alb_name              = "jenkins"
  alb_protocols         = ["HTTP"]
  alb_security_groups   = ["${module.jenkins_http.this_security_group_id}"]
  certificate_arn       = ""
  health_check_path     = "/"
  health_check_port     = "8080"
  health_check_interval = "30"
  health_check_matcher  = "403"
  deregistration_delay  = "60"
  create_log_bucket     = true                                              //Mandatory otherwise module fails
  log_bucket_name       = "jenkinsaccesslogbuckettempt"
  log_location_prefix   = "alb"
  subnets               = "${module.vpc.public_subnets}"
  tags                  = "${map("Environment", "jenkins")}"
  vpc_id                = "${module.vpc.vpc_id}"
  target_type           = "ip"
}
