module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v1.23.0"

  name = "jenkins"

  cidr = "10.100.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.100.1.0/24", "10.100.2.0/24"]
  public_subnets  = ["10.100.11.0/24", "10.100.12.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "jenkins"
    Name        = "jenkins"
  }
}
