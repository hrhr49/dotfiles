DOCKER_TAG_NAME='hrhr49-dotfiles'

# シェルスクリプトのリスト。git applyするときに'./'がつくとうまく行かない？
SHELL_SCRIPTS=`find . -name '*.sh' \
			  -or -name 'bashrc' \
			  -or -name 'xinitrc' \
			  -or -name 'commonshrc' \
			  -or -path './scripts/cli/util/*' \
			  | sed 's,./,,' \
			  `

.PHONY: install test docker-build shell clean

install:
	python3 install.py

test:
	docker run --name dotfiles-test --rm -v ${PWD}:/home/user/dotfiles ${DOCKER_TAG_NAME} python3 /home/user/dotfiles/install.py

docker-build:
	docker build -t ${DOCKER_TAG_NAME} .

shell:
	docker run --name ${DOCKER_TAG_NAME} -it --rm -v ${PWD}:/home/user/dotfiles ${DOCKER_TAG_NAME}

clean:
	rm -rf build/*

# 未使用変数のエラー(SC2034)はチェックしない
# 非定数のsourceコマンドのエラー(SC1090)はチェックしない
# sourceコマンドのアクセスできないエラー(SC1091)はチェックしない
# shebangがshやbash以外の場合(zshなど)のときのエラー(SC1071)はチェックしない
check:
	shellcheck -e SC2034 -e SC1090 -e SC1091 -e 1071 ${SHELL_SCRIPTS}

fix:
	shellcheck -f diff ${SHELL_SCRIPTS} | git apply

permit:
	chmod +x `find . -path './scripts/cli/util/*' `
