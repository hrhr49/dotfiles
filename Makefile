DOCKER_TAG_NAME='hrhr49-dotfiles'

.PHONY: install test docker-build shell clean

install:
	python3 install.py

test:
	docker run --name poppler-build --rm -v ${PWD}:/home/user/dotfiles ${DOCKER_TAG_NAME} python3 /home/user/dotfiles/install.py

docker-build:
	docker build -t ${DOCKER_TAG_NAME} .

shell:
	docker run --name poppler-build -it --rm -v ${PWD}:/home/user/dotfiles ${DOCKER_TAG_NAME}

clean:
	rm -rf build/*
