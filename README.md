# Jenkins on AWS Fargate

## Create

```bash
terraform init
terraform plan
terraform apply
```

## TODO

* Default terraform module
* Automatically configure agents
  * Fix settings in fargate.groovy
  * Create public docker hub repo for the agent
  * Add settings to jenkins.tf that are needed by fargate.groovy
  * Open port 50000 and Security Group
  * Run Jenkins and configure it until I have an agent
* Write readme
* Infrastructure drawing