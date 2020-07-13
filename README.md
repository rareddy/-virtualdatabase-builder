# Virtual Database Builder

This is base Java build image for building Virtual Databases using Teiid Spring Boot. This image has _most_ all the required maven dependencies cached other than any 3rd party or private maven repositories.

The below command is to build the image locally once, which will cache all the maven artifacts needed in a image for a VDB build (this only needs to be done once for development, the vscode user does not do this)

```
make
```

make sure you have the image by executing below

```
$docker images
REPOSITORY                                        TAG      IMAGE ID       CREATED          SIZE
localhost/rareddy/virtualdatabase-builder         latest   3b0b53327c58   11 minutes ago   1.28 GB
```

If you have a YAML file for VDB CR for Teiid like below `sampledb.yaml` in your local directory

```
apiVersion: teiid.io/v1alpha1
kind: VirtualDatabase
metadata:
  name: sampledb
spec:
  replicas: 1
  expose:
    - LoadBalancer
  datasources:
    - name: sampledb
      type: h2
      properties:
        - name: username
          value: sa
        - name: password
          value: sa
        - name: jdbc-url
          value: jdbc:h2:mem:sampledb;DB_CLOSE_ON_EXIT=FALSE;DB_CLOSE_DELAY=-1;INIT=create table note(id integer primary key, msg varchar(80))\\;INSERT INTO note VALUES(1, 'First note')\\;INSERT INTO note VALUES(2, 'Second note');
  build:
    source:
      ddl: |
        CREATE DATABASE sampledb OPTIONS (ANNOTATION 'Sample VDB');
        USE DATABASE sampledb;

        CREATE SERVER sampledb FOREIGN DATA WRAPPER h2;

        CREATE SCHEMA accounts SERVER sampledb;

        -- H2 converts the schema name to capital case
        IMPORT FOREIGN SCHEMA PUBLIC FROM SERVER sampledb INTO accounts;
```

Start the container, and volume mount the current directory as shown below

```
docker run --volume .:/home/jboss/vdb:z -it localhost/{your-name}/virtualdatabase-builder:latest /bin/bash
```

for my user name this will be like

```
docker run --volume .:/home/jboss/vdb:z -p5432:35432 -it localhost/rareddy/virtualdatabase-builder:latest /bin/bash
```

This will start the image as container, and user will be presented with a shell command to further execute any commands. To build and execute the project run

```
run.sh sampledb
```

where `sampledb` is the name of the YAML file and also name of the virtualization, in this case from `sampledb` project.

make sure the above app is running, then connect to the SQL interface using the SQLClient plugin
