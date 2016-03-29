FROM centos:centos6

MAINTAINER Priit Liivak

RUN echo "====> Installing EPEL... <====" && \
    yum -y install epel-release && \
    \
    \
    echo "====> Installing utilities... <====" && \
    yum -y install sudo unzip && \
    \
    \
    echo "====> Installing Ansible... <====" && \
    yum -y install ansible && \
    \
    \
    echo "====> Installing Java... <====" && \
    yum -y install java-1.7.0-openjdk

RUN echo "====> Removing unused YUM resources... <====" && \
    yum -y remove epel-release && \
    yum clean all

## SonarQube installation

ENV SONARQUBE_HOME /opt/sonarqube

# Http port
EXPOSE 9000

# Database configuration
# Defaults to using H2
ENV SONARQUBE_JDBC_USERNAME sonar
ENV SONARQUBE_JDBC_PASSWORD sonar
ENV SONARQUBE_JDBC_URL jdbc:h2:tcp://localhost:9092/sonar

ENV SONAR_VERSION 5.1

# pub   2048R/D26468DE 2015-05-25
#       Key fingerprint = F118 2E81 C792 9289 21DB  CAB4 CFCA 4A29 D264 68DE
# uid                  sonarsource_deployer (Sonarsource Deployer) <infra@sonarsource.com>
# sub   2048R/06855C1D 2015-05-25
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE

RUN set -x \
	&& cd /opt \
	&& curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
	&& curl -o sonarqube.zip.asc -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
	&& gpg --batch --verify sonarqube.zip.asc sonarqube.zip \
	&& unzip sonarqube.zip \
	&& mv sonarqube-$SONAR_VERSION sonarqube \
	&& rm sonarqube.zip* \
	&& rm -rf $SONARQUBE_HOME/bin/*

VOLUME ["$SONARQUBE_HOME/data", "$SONARQUBE_HOME/extensions"]

WORKDIR $SONARQUBE_HOME

CMD [ "java", "-version" ]