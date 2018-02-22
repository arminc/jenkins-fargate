# Jenkins on AWS Fargate

## Create

```bash
terraform init
terraform plan
terraform apply
```

## TODO

- [] Add ALB and connect Jenkins to it
- [] Use a service role, otherwise one get's attached
- [] Fix task settings like grace period or % running
- [] Use hash for task-definition.json so it does not recreate it
- [] Configure Jenkins to have agents (manually)
- [] Automatically configure agents
- [] Infrastructure drawing