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

This image has folder "/home/jboss/sample" where a sample java project that represents Java project that need to be generated from a given YAML file that is created in VSCode plugin. For example purposes this "sample" file given, in future this will be replaced with a actual code generation.

Start the container, and volume mount the current directory

```
docker run --volume .:/home/jboss/yamlvdb:z -it localhost/{your-name}/virtualdatabase-builder:latest /bin/bash
```

for my user name this will be like

```
docker run --volume .:/home/jboss/yamlvdb:z -p5432:35432 -it localhost/rareddy/virtualdatabase-builder:latest /bin/bash
```

This will start the image as container, and user will be presented with a shell command to further execute any commands. To build and execute the project run

```
cd vdb
run.sh dv-customer
```

where `dv-customer` is the name of the virtualization from YAML file, in this case from `sample` project.

make sure the above app is running, then connect to the SQL interface using the SQLClient plugin
