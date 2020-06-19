#!/bin/sh

NAME=$1
JAVA_VERSION=11

cd $1

mvn -B \
    -Dmaven.repo.local=/tmp/artifacts/m2 \
    -Dteiid.springboot.version=${TEIID_SPRINGBOOT_VERSION} \
    -Dspringboot.version=${SPRINGBOOT_VERSION} \
    -Dmaven.compiler.source=${JAVA_VERSION} \
    -Dmaven.compiler.target=${JAVA_VERSION} \
    -DskipTests \
    -Dmaven.javadoc.skip=true \
    -Dmaven.site.skip=true \
    -Dmaven.source.skip=true \
    -Djacoco.skip=true \
    -Dcheckstyle.skip=true \
    -Dfindbugs.skip=true \
    -Dpmd.skip=true \
    -Dfabric8.skip=true \
    -f pom.xml clean install

java -jar target/${NAME}-1.0.0.jar