#!/bin/sh

NAME=$1

cd sample

mvn -B -Dmaven.repo.local=/tmp/artifacts/m2 -Dmaven.site.skip=true -Djacoco.skip=true -Dcheckstyle.skip=true -Dmaven.compiler.source=1.11 -Dmaven.compiler.target=1.11  clean install

java -jar target/${NAME}-1.0.0.jar