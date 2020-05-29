# Virtual Database Builder

This is base Java build image for building Virtual Databases using Teiid Spring Boot. This image has _most_ all the required maven dependencies cached other than any 3rd party or private maven repositories.

Start the container, where `/hostdir` where your `pom.xml` file is exists.

```
podman run --volume /hostdir:~/vdb -it quay.io/teiid/virtualdatabase-builder:latest /bin/bash

mvn -B -Dmaven.repo.local=/tmp/artifacts/m2 install

```
