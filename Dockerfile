FROM ubuntu:20.04

# インタラクティブな選択画面を使用しない
ENV DEBIAN_FRONTEND=noninteractive

# 先にtzdataを入れないと、タイムゾーンの選択画面が出てしまう(Ubuntu18.04以降)
# https://qiita.com/yagince/items/deba267f789604643bab
RUN apt-get -y update && \
    apt-get -y install \
    tzdata

# Build Environment
RUN apt-get -y update && \
apt-get -y install \
    language-pack-ja-base \
    language-pack-ja \
    sudo

# Utility
RUN apt-get -y update && \
apt-get -y install \
	python3 \
	wget \
    curl \
	zip \
    unzip \
	git

# 日本語の文字化けなどを回避
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

ENV USER user
ENV HOME /home/${USER}
ENV SHELL /bin/bash

# 一般ユーザアカウントを追加
# -m オプションで、user:userでホームディレクトリを作る
# -s オプションでログインシェルを指定
RUN useradd -G video -ms /bin/bash ${USER}

# 一般ユーザにsudo権限を付与
RUN gpasswd -a ${USER} sudo

# 一般ユーザのパスワード設定
RUN echo "${USER}:${USER}" | chpasswd

# 以降のRUN/CMDを実行するユーザ
USER ${USER}

WORKDIR ${HOME}

