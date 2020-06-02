REGISTRY?=`whoami`
IMAGE=virtualdatabase-builder
TAG?=latest
IMAGE_NAME=$(REGISTRY)/$(IMAGE):$(TAG)
QUAY_REPOSITORY?=quay.io/teiid/virtualdatabase-builder

.PHONY: all
all: build

.PHONY: build
build:
	mvn -B -s ./build/settings.xml -Dmaven.repo.local=./build/m2 -f ./build/pom.xml clean install
	buildah bud -t $(IMAGE_NAME) .
	rm -f ${project.basedir}

.PHONY: quay-push
quay-push:
	buildah push $(IMAGE_NAME) $(QUAY_REPOSITORY):$(TAG)

.PHONY: clean
clean:
	mvn -B -s ./build/settings.xml -Dmaven.site.skip=true -Djacoco.skip=true -Dcheckstyle.skip=true -Dmaven.compiler.source=1.11 -Dmaven.compiler.target=1.11 -Dmaven.repo.local=./build/m2 -f ./build/pom.xml clean
	rm build/m2
