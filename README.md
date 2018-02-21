# Jenkins on AWS Fargate

## Create

```bash
terraform init
terraform plan
terraform apply
```

## TODO

- [] Run Jenkins in private subnet
  - [] Use a service role, otherwise one get's attached
- [] Add ALB and connect Jenkins to it
- [] Fix task settings like grace period or % running
- [] Configure Jenkins to have agents (manually)
- [] Automatically configure agents
- [] Infrastructure drawing