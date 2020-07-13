#!/bin/sh

NAME=$1
JAVA_VERSION=11

# build the sample project from the YAML file
mvn -B \
    -Dmaven.repo.local=/tmp/artifacts/m2 \
    -Dteiid.springboot.version=${TEIID_SPRINGBOOT_VERSION} \
    -Dspringboot.version=${SPRINGBOOT_VERSION} \
    -Dmaven.compiler.source=${JAVA_VERSION} \
    -Dmaven.compiler.target=${JAVA_VERSION} \
    -Dvdb.name=${NAME} \
    -f pom.xml clean install

# Make sure above build is successful
if [[ "$?" -ne 0 ]] ; then
  echo 'failed' > result.txt; exit $rc
else
  rm -rf ${NAME}
  mkdir ${NAME}
  cp -R /home/jboss/target/generated-sources/teiid-sb/* ${NAME}
fi

# Build project that is generated in the previous step
cd ${NAME}
mvn -B \
    -Dmaven.repo.local=/tmp/artifacts/m2 \
    -Dteiid.springboot.version=${TEIID_SPRINGBOOT_VERSION} \
    -Dspringboot.version=${SPRINGBOOT_VERSION} \
    -Dmaven.compiler.source=${JAVA_VERSION} \
    -Dmaven.compiler.target=${JAVA_VERSION} \
    -Dbasepom.check.skip-dependency-versions-check=true \
    -Dbasepom.check.skip-duplicate-finder=true \
    -Dbasepom.check.skip-dependency=true \
    -Dbasepom.check.skip-license=true \
    -Dvdb.name=${NAME} \
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

# Run the project
if [[ "$?" -ne 0 ]] ; then
  echo 'failed' > result.txt; exit $rc
else
  java -jar target/${NAME}-1.0.0.jar
fi

