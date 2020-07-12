DOCKER_TAG_NAME='hrhr49-dotfiles'

# シェルスクリプトのリスト。git applyするときに'./'がつくとうまく行かない？
SHELL_SCRIPTS=`find . -name '*.sh' \
			  -or -name 'bashrc' \
			  -or -name 'xinitrc' \
			  -or -name 'commonshrc' \
			  | sed 's,./,,' \
			  `

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

# 未使用変数のエラー(SC2034)はチェックしない
# 非定数のsourceコマンドのエラー(SC1090)はチェックしない
check:
	shellcheck -e SC2034 -e 1090 ${SHELL_SCRIPTS}

fix:
	shellcheck -f diff ${SHELL_SCRIPTS} | git apply
