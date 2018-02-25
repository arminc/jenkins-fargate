import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()
def env = System.getenv()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin",env["ADMIN_PASSWORD"] ?: 'admin')
instance.setSecurityRealm(hudsonRealm)
def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, "admin")
instance.setAuthorizationStrategy(strategy)
instance.save()