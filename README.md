# Virtual Database Builder

This is base Java build image for building Virtual Databases using Teiid Spring Boot. This image has _most_ all the required maven dependencies cached other than any 3rd party or private maven repositories.

Start the container, where `/hostdir` where your `pom.xml` file is exists.

```
make
docker run --volume .:/home/jboss/vdb/sample -it localhost/{your-name}/virtualdatabase-builder:latest /bin/bash

# now in the shell of the container

# move to directory where vdb is defined (ex: sample), how this sample directory generated from the YAML file is TBD
cd sample

# build the java project
mvn -B -Dmaven.repo.local=/tmp/artifacts/m2 install

# run the java project
java -jar target/dv-customer-1.0.0.jar
```
