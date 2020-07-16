FROM registry.access.redhat.com/ubi8/openjdk-11:1.3

ARG TEIID_SPRINGBOOT_VERSION
ARG SPRINGBOOT_VERSION

ENV TEIID_SPRINGBOOT_VERSION=$TEIID_SPRINGBOOT_VERSION
ENV SPRINGBOOT_VERSION=$SPRINGBOOT_VERSION

COPY build/m2 /tmp/artifacts/m2
COPY run.sh /home/jboss/run.sh
COPY pom.xml /home/jboss/pom.xml
#RUN chmod +x /home/jboss/run.sh

