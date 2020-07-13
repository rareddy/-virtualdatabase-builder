REGISTRY?=`whoami`
IMAGE=virtualdatabase-builder
TAG?=latest
IMAGE_NAME=$(REGISTRY)/$(IMAGE):$(TAG)
QUAY_REPOSITORY?=quay.io/teiid/virtualdatabase-builder
TEIID_SPRINGBOOT_VERSION=1.6.0-SNAPSHOT
SPRINGBOOT_VERSION=2.2.6.RELEASE
JAVA_VERSION=11

.PHONY: all
all: build

.PHONY: build
build:
	mvn -B -s ./build/settings.xml \
	  -Dmaven.repo.local=./build/m2 \
	  -Dteiid.springboot.version=$(TEIID_SPRINGBOOT_VERSION) \
	  -Dspringboot.version=$(SPRINGBOOT_VERSION) \
	  -Dmaven.compiler.source=$(JAVA_VERSION) \
	  -Dmaven.compiler.target=$(JAVA_VERSION) \
	  -DskipTests \
	  -Dmaven.javadoc.skip=true \
	  -Dmaven.site.skip=true \
	  -Dmaven.source.skip=true \
	  -Djacoco.skip=true \
	  -Dcheckstyle.skip=true \
	  -Dfindbugs.skip=true \
	  -Dpmd.skip=true \
	  -Dfabric8.skip=true \
	  -Dbasepom.check.skip-dependency=true \
	  -Dbasepom.check.skip-duplicate-finder=true \
	  -Dbasepom.check.skip-spotbugs=true \
	  -Dbasepom.check.skip-dependency-versions-check=true \
	  -Dbasepom.check.skip-dependency-management=true \
	  -Dbasepom.check.skip-dependency-scope=true \
	  -Dbasepom.check.skip-license=true \
	  -Dbasepom.check.skip-pmd=true \
	  -Dbasepom.check.skip-checkstyle=true \
	  -Dbasepom.check.skip-javadoc=true \
	  -f ./build/pom.xml clean install
	buildah bud --build-arg TEIID_SPRINGBOOT_VERSION=$(TEIID_SPRINGBOOT_VERSION) --build-arg SPRINGBOOT_VERSION=$(SPRINGBOOT_VERSION) -t $(IMAGE_NAME) .

.PHONY: quay-push
quay-push:
	buildah push $(IMAGE_NAME) $(QUAY_REPOSITORY):$(TAG)

.PHONY: clean
clean:
	rm -rf build/target
	rm -rf build/m2
