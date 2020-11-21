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

# install dotfiles
RUN mkdir -p /home/${USERNAME}/memo

# install python to run install.py
RUN sudo pacman -Syyu --noconfirm python

ARG CACHEBUST=1
RUN git clone https://github.com/hrhr49/dotfiles /home/${USERNAME}/memo/dotfiles
RUN cd /home/${USERNAME}/memo/dotfiles && python install.py

# install pacman packages
RUN /home/${USERNAME}/memo/dotfiles/scripts/cli/update/pacman.sh

# install yay packages
RUN /home/${USERNAME}/memo/dotfiles/scripts/cli/update/yay.sh

# install tools
RUN /home/${USERNAME}/memo/dotfiles/scripts/cli/install/all.sh

# install packages
RUN /home/${USERNAME}/memo/dotfiles/scripts/cli/update/all.sh

CMD ["/bin/zsh"]
