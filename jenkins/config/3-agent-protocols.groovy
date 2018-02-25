import jenkins.model.*

def instance = Jenkins.getInstance()
def protocols = instance.getAgentProtocols()
println "default agent protocols:" + protocols

protocols.removeIf { it == "JNLP-connect" }
protocols.removeIf { it == "JNLP2-connect" }
protocols.removeIf { it == "JNLP3-connect" }
protocols.removeIf { it == "CLI-connect" }
protocols.removeIf { it == "CLI2-connect" }

println "remaining agent protocols:" + protocols
instance.setAgentProtocols(protocols)