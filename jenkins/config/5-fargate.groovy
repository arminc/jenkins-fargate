import hudson.model.*
import jenkins.model.*
import com.cloudbees.jenkins.plugins.amazonecs.*
import java.util.Collections

def instance = Jenkins.getInstance()
def env = System.getenv()

def cloudList = instance.clouds

List emptyList = new ArrayList() 
List<ECSTaskTemplate> slaves = new ArrayList<ECSTaskTemplate>()
List<ECSTaskTemplate.LogDriverOption> logDriverOptions = new ArrayList<ECSTaskTemplate.LogDriverOption>()

logDriverOptions.add(new ECSTaskTemplate.LogDriverOption('awslogs-group', 'jenkins'))
logDriverOptions.add(new ECSTaskTemplate.LogDriverOption('awslogs-region', 'us-east-1'))
logDriverOptions.add(new ECSTaskTemplate.LogDriverOption('awslogs-stream-prefix', 'master')) 

def slaveInfo = new ECSTaskTemplate(
  templateName = 'SlaveOne',
  label = 'SlaveOne',
  image = 'jenkins/jnlp-slave',
  launchType = 'FARGATE',
  remoteFSRoot = '/home/jenkins',
  executionRole = env["TASK_EXECUTION_ROLE"] ?: 'arn',
  memory = 2048,
  memoryReservation = 2048,
  cpu = 1024,
  subnets = env["SUBNETS"] ?: 'subnet',
  securityGroups = env["SECURITY_GROUPS"] ?: 'sg',
  assignPublicIp = false,
  privileged = false,
  logDriverOptions = logDriverOptions,
  environments = emptyList,
  extraHosts = emptyList,
  mountPoints = emptyList
)

slaveInfo.setLogDriver('awslogs')

slaves.add(slaveInfo)

//Default ECS plugin configuration
def cloud = new ECSCloud(
    name = 'Fargate',
    templates = slaves,
    credentialsId = 'aaa',
    cluster = 'jenkins',
    regionName = 'us-east-1',
    jenkinsUrl = '',
    slaveTimoutInSeconds = 100
)

cloudList.add(cloud)