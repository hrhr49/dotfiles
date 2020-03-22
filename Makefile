# vim:set foldmethod=marker foldlevel=0:
# dotファイル管理などのMakefile
# 参考: https://github.com/masasam/dotfiles/blob/master/Makefile
# 注意：Makefile中で$マークを文字列として使う際は$$を使う

INSTALL=sudo apt install -y
INSTALL_UPDATE=sudo apt update -y
INSTALL_UPGRADE=sudo apt upgrade -y

# 初回設定
init:
	make init_dotfiles

# 初回設定ファイルインストール。強制上書きが嫌な場合はvsにオプションを変える
# 一部のみ実行したいときなどはvimの範囲選択からbashに食わせるなどする
init_dotfiles:
	mkdir -p ${HOME}/.config/i3
	mkdir -p ${HOME}/.config/i3status
	mkdir -p ${HOME}/.config/nvim
	mkdir -p ${HOME}/.config/ranger
	mkdir -p ${HOME}/.config/rofi
	mkdir -p ${HOME}/.config/qutebrowser
	mkdir -p ${HOME}/.config/zathura
	mkdir -p ${HOME}/.config/xfce4/terminal
	mkdir -p ${HOME}/.config/compton
	ln -vsf ${PWD}/xinitrc ${HOME}/.xinitrc
	ln -vsf ${PWD}/Xresources ${HOME}/.Xresources
	ln -vsf ${PWD}/config/i3/config ${HOME}/.config/i3/config
	ln -vsf ${PWD}/config/i3status/config ${HOME}/.config/i3status/config
	ln -vsf ${PWD}/config/ranger/commands.py ${HOME}/.config/ranger/commands.py
	ln -vsf ${PWD}/config/ranger/rc.conf ${HOME}/.config/ranger/rc.conf
	ln -vsf ${PWD}/config/ranger/scope.sh ${HOME}/.config/ranger/scope.sh
	ln -vsf ${PWD}/config/rofi/config.rasi ${HOME}/.config/rofi/config.rasi
	ln -vsf ${PWD}/config/qutebrowser/config.py ${HOME}/.config/qutebrowser/config.py
	ln -vsf ${PWD}/config/qutebrowser/solarized.css ${HOME}/.config/qutebrowser/solarized.css
	ln -vsf ${PWD}/config/zathura/zathurarc ${HOME}/.config/zathura/zathurarc
	ln -vsf ${PWD}/config/xfce4/terminal/accels.scm ${HOME}/.config/xfce4/terminal/accels.scm
	ln -vsf ${PWD}/ctags ${HOME}/.ctags
	ln -vsf ${PWD}/config/compton/compton.conf ${HOME}/.config/compton/compton.conf
	echo "source ${PWD}/commonshrc" >> $(HOME)/.bashrc
	echo "source ${PWD}/bashrc" >> $(HOME)/.bashrc
	echo "source ${PWD}/commonshrc" >> $(HOME)/.zshrc
	echo "source ${PWD}/zshrc" >> $(HOME)/.zshrc
	echo "source-file ${PWD}/tmux.conf" >> $(HOME)/.tmux.conf
	echo "source ${PWD}/vimrc" >> $(HOME)/.vimrc
	echo "source ${PWD}/config/nvim/init.vim" >> $(HOME)/.config/nvim/init.vim
	echo "source ${PWD}/profile" >> $(HOME)/.profile

