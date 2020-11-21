DOCKER_TAG_NAME='hrhr49/develop'
DOCKER_CONTAINER_NAME='hrhr49-develop'

.PHONY: install test docker-build shell clean

build:
	docker build -t ${DOCKER_TAG_NAME} --build-arg CACHEBUST=$$(date +%s) . 2>&1 | tee log

build-nocache:
	docker build --no-cache -t ${DOCKER_TAG_NAME} . 2>&1 | tee log

shell:
	docker run --name ${DOCKER_CONTAINER_NAME} -it --rm ${DOCKER_TAG_NAME}

run:
	docker run --name ${DOCKER_CONTAINER_NAME} -it --rm -v ${PWD}:/home/user/workspace ${DOCKER_TAG_NAME}


