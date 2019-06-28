# vim:set foldmethod=marker foldlevel=0:
# dotファイル管理などのMakefile
# 参考: https://github.com/masasam/dotfiles/blob/master/Makefile
# 注意：Makefile中で$マークを文字列として使う際は$$を使う
# TODO:
# zsh fzf fasd
# node ruby

INSTALL=sudo apt install -y
INSTALL_UPDATE=sudo apt update -y
INSTALL_UPGRADE=sudo apt upgrade -y

# 初回設定
init:
	make init_dotfiles
	make init_install
	make init_option

init_gui:
	make init_gui_install

# 初回設定ファイルインストール。強制上書きが嫌な場合はvsにオプションを変える
init_dotfiles:
	mkdir -p ${HOME}/.config/i3
	mkdir -p ${HOME}/.config/i3status
	mkdir -p ${HOME}/.config/nvim
	mkdir -p ${HOME}/.config/ranger
	mkdir -p ${HOME}/.config/rofi
	ln -vsf ${PWD}/vimrc ${HOME}/.vimrc
	ln -vsf ${PWD}/tmux.conf ${HOME}/.tmux.conf
	ln -vsf ${PWD}/Xresources ${HOME}/.Xresources
	ln -vsf ${PWD}/config/i3/config ${HOME}/.config/i3/config
	ln -vsf ${PWD}/config/i3status/config ${HOME}/.config/i3status/config
	ln -vsf ${PWD}/config/nvim/init.vim ${HOME}/.config/nvim/init.vim
	ln -vsf ${PWD}/config/ranger/commands.py ${HOME}/.config/ranger/commands.py
	ln -vsf ${PWD}/config/ranger/rc.conf ${HOME}/.config/ranger/rc.conf
	ln -vsf ${PWD}/config/rofi/config.rasi ${HOME}/.config/rofi/config.rasi
	echo "source ${PWD}/commonshrc" >> $(HOME)/.bashrc
	echo "source ${PWD}/bashrc" >> $(HOME)/.bashrc
	echo "source ${PWD}/commonshrc" >> $(HOME)/.zshrc
	echo "source ${PWD}/zshrc" >> $(HOME)/.zshrc

init_install:
	$(INSTALL_UPDATE)
	$(INSTALL_UPGRADE)
	$(INSTALL) build-essential coreutils vim tmux git ranger \
	htop unzip fasd zsh

init_gui_install:
	$(INSTALL) rofi sxiv zathura chromium-browser

# 初回設定で欲しいけど必須じゃないもの
init_option:
	make zsh
	make fzf
	make fasd
	make python
	make pyenv
	make pip_install
	make neovim

python:
	$(INSTALL) python3-dev python3-pip
	# build-essential libbz2-dev libdb-dev \
	# libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
	# libncursesw5-dev libsqlite3-dev libssl-dev \
	# zlib1g-dev uuid-dev tk-dev python3-dev python3-pip

pip_install:
	pip install neovim requests flask jedi \
	python-language-server

# pyenvのインストール
pyenv:
	if [ ! -e ${HOME}/.pyenv ]; then \
	git clone https://github.com/pyenv/pyenv.git ${HOME}/.pyenv; \
	fi
	echo 'export PYENV_ROOT="$$HOME/.pyenv"' >> ${HOME}/.bashrc
	echo 'export PATH="$$PYENV_ROOT/bin:$$PATH"' >> ${HOME}/.bashrc
	echo 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$$(pyenv init -)"\nfi' >> ${HOME}/.bashrc
	echo 'export PYENV_ROOT="$$HOME/.pyenv"' >> ${HOME}/.zshrc
	echo 'export PATH="$$PYENV_ROOT/bin:$$PATH"' >> ${HOME}/.zshrc
	echo 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$$(pyenv init -)"\nfi' >> ${HOME}/.zshrc
	exec "$${SHELL}"
	pyenv install 3.6.8
	pyenv global 3.6.8
	exec "$${SHELL}"

# neovimのインストール TODO: aptじゃない環境対応
neovim:
	sudo apt-get install software-properties-common
	sudo add-apt-repository ppa:neovim-ppa/stable
	sudo apt-get update
	sudo apt-get install neovim
	curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
	${HOME}/.fzf/install

zsh:
	$(INSTALL) zsh
	git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
	cp ${HOME}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME}/.zshrc
	sed -ie 's/ZSH_THEME="robbyrussell"/ZSH_THEMEE="lukerandall"/' ${HOME}/.zshrc
	echo "source ${PWD}/commonshrc" >> $(HOME)/.zshrc
	echo "source ${PWD}/zshrc" >> $(HOME)/.zshrc

fasd:
	$(INSTALL) fasd
	echo 'eval "$$(fasd --init auto)"' >> ${HOME}/.bashrc
	echo 'eval "$$(fasd --init auto)"' >> ${HOME}/.zshrc

# i3wmの設定
i3wm:
	make i3wm_dotfiles
	make i3wm_install

i3wm_dotfiles:
	ln -vsf ${PWD}/xinitrc ${HOME}/.xinitrc

i3wm_install:
	$(INSTALL) i3 fcitx-mozc feh compton variety alsa-utils dunst \
	pasystray rofi
