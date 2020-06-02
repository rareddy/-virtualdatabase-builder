FROM registry.access.redhat.com/ubi8/openjdk-11:1.3

COPY build/m2 /tmp/artifacts/m2
COPY sample /home/jboss/vdb/sample 
COPY run.sh /home/jboss/vdb/run.sh
RUN chmod +x /home/jboss/vdb/run.sh

