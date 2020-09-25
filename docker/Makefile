DOCKER_TAG_NAME='hrhr49-dev-archlinux'

.PHONY: install test docker-build shell clean

build:
	docker build -t ${DOCKER_TAG_NAME} .

shell:
	docker run --name ${DOCKER_TAG_NAME} -it --rm ${DOCKER_TAG_NAME}

run:
	docker run --name ${DOCKER_TAG_NAME} -it --rm -v ${PWD}:/home/user/ ${DOCKER_TAG_NAME}


