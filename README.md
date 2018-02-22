# Jenkins on AWS Fargate

## Create

```bash
terraform init
terraform plan
terraform apply
```

## TODO

- [] ALB can't make taks healthy
- [] Use hash for task-definition.json so it does not recreate it
- [] Fix task settings like grace period or % running
- [] Disable admin password
- [] Change health check to be 200 instead of 403
- [] Configure Jenkins to have agents (manually)
- [] Automatically configure agents
- [] Infrastructure drawing