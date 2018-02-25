import jenkins.model.*

def instance = Jenkins.getInstance()
def env = System.getenv()

//Configure 1 executor on Master
instance.setNumExecutors(1)
instance.setLabelString("master")

//Jenkins URL
jlc = JenkinsLocationConfiguration.get()
jlc.setUrl(env["JENKINS_URL"] ?: '')
jlc.setAdminAddress(env["JENKINS_EMAIL"] ?: '')
jlc.save() 