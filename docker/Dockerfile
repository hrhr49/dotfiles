# ポータブルな開発環境を作るためのDockerfile
# このDockerイメージにとりあえずいろいろ入れておく
# 参考： https://qiita.com/u1and0/items/88e3dd5efbdb0a496959
FROM archlinux/base:latest

# Japanese setting
ENV LANG="ja_JP.UTF8"\
    LC_NUMERIC="ja_JP.UTF8"\
    LC_TIME="ja_JP.UTF8"\
    LC_MONETARY="ja_JP.UTF8"\
    LC_PAPER="ja_JP.UTF8"\
    LC_MEASUREMENT="ja_JP.UTF8"

RUN echo ja_JP.UTF-8 UTF-8 > /etc/locale.gen &&\
    locale-gen &&\
    ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime &&\
    chmod -R 755 /etc/pacman.d &&\
    sed -ie 's/#Color/Color/' /etc/pacman.conf &&\
    pacman -Syyu --noconfirm git openssh base-devel &&\
    pacman -Qtdq | xargs -r pacman --noconfirm -Rcns

# install basic commands
RUN pacman -Syyu --noconfirm \
    which \
    curl \
    wget \
    man \
    zip \
    unzip

# install development environment
RUN pacman -Syyu --noconfirm \
    git \
    python \
    make \
    cmake \
    gcc \
    nodejs \
    npm \
    yarn \
    ruby \
    go \
    rust \
    nim

# install utility
RUN pacman -Syyu --noconfirm \
    zsh \
    neovim \
    python-pynvim \
    ctags \
    tmux \
    fzf \
    ripgrep \
    bat \
    tig \
    tokei \
    tldr \
    fd \
    ranger \
    tree \
    htop \
    unarchiver \
    jq
    # fasd \

# other
RUN pacman -Syyu --noconfirm \
    python-pip \
    rubygems \
    vim

# install packages for python
RUN pip install \
    pynvim \
    neovim

# install packages for nodejs
RUN npm install -g \
    neovim

# install packages for ruby
RUN gem install \
    neovim

ARG USERNAME=user
# docker build --Build-arg USERNAME=${USERNAME} -t u1and0/archlinux .
ARG UID=1000
ARG GID=1000
RUN echo "Build start with USERNAME: $USERNAME UID: $UID GID: $GID" &&\
    echo '[multilib]' >> /etc/pacman.conf &&\
    echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf &&\
    pacman -Sy &&\
    groupadd -g ${GID} ${USERNAME} &&\
    useradd -u ${UID} -g ${GID} -m -s /bin/zsh ${USERNAME} &&\
    passwd -d ${USERNAME} &&\
    mkdir -p /etc/sudoers.d &&\
    touch /etc/sudoers.d/${USERNAME} &&\
    echo "${USERNAME} ALL=(ALL) ALL" > /etc/sudoers.d/${USERNAME} &&\
    mkdir -p /home/${USERNAME}/.gnupg &&\
    echo 'standard-resolver' > /home/${USERNAME}/.gnupg/dirmngr.conf &&\
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME} &&\
    mkdir /build &&\
    chown -R ${USERNAME}:${USERNAME} /build

# yay install
WORKDIR "/build"
RUN sudo -u ${USERNAME} git clone --depth 1 https://aur.archlinux.org/yay.git
WORKDIR "/build/yay"
RUN sudo -u ${USERNAME} makepkg --noconfirm -si &&\
    sudo -u ${USERNAME} yay --afterclean --removemake --save &&\
    pacman -Qtdq | xargs -r pacman --noconfirm -Rcns &&\
    rm -rf /home/${USERNAME}/.cache &&\
    rm -rf /build

WORKDIR /home/${USERNAME}
USER ${USERNAME}

RUN yay -Syuu --noconfirm \
    nkf \
    perl-graph-easy \
    gibo

# install dotfiles
RUN mkdir -p /home/${USERNAME}/memo
RUN git clone https://github.com/hrhr49/dotfiles /home/${USERNAME}/memo/dotfiles
RUN cd /home/${USERNAME}/memo/dotfiles && python install.py

# install vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN vim -c 'PlugInstall|qa'
RUN mkdir -p /home/${USERNAME}/.config/coc
# vimrcのg:coc_global_extensionsのを全部Installする。dockerビルド時に何も表示されない時間が数分続いたけど、ちゃんとできていた。
RUN vim -c 'execute "CocInstall -sync " . join(g:coc_global_extensions, " ")|qa'
# nvimの方で同じことをしたら、うまく行かなかったっぽい

# install zinit
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
# RUN zsh /home/${USERNAME}/.zshrc
RUN zsh -i -c exit

# install tpm
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# pylintを入れとかないと、coc-pythonがうるさい。
RUN pip install \
    pylint \
    pipenv

CMD ["/bin/zsh"]
