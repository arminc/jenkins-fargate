FROM jenkins/jenkins:2.108-alpine

RUN echo -n 2 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion && \
    echo -n 2 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

COPY config/* /usr/share/jenkins/ref/init.groovy.d/

RUN /usr/local/bin/install-plugins.sh \
    matrix-auth:2.2 \
    aws-java-sdk:1.11.264 \
    aws-credentials:1.23

RUN curl -fSL https://github.com/marktb1/amazon-ecs-plugin/releases/download/amazon-ecs-1.0-beta2/amazon-ecs.hpi -o /usr/share/jenkins/ref/plugins/amazon-ecs.hpi 2> /dev/null
