#!/usr/bin/env python3

# -*- coding: utf-8 -*-
'''
Install dotfiles
'''

import os
import os.path

HERE = os.path.abspath(os.path.dirname(__file__))
HOME = os.environ['HOME']

# move to this directory for change PWD
os.chdir(HERE)
os.environ['PWD'] = HERE

links = [
    ['${PWD}/xinitrc', '${HOME}/.xinitrc'],
    ['${PWD}/xprofile', '${HOME}/.xprofile'],
    ['${PWD}/Xresources', '${HOME}/.Xresources'],
    ['${PWD}/config/i3/config', '${HOME}/.config/i3/config'],
    ['${PWD}/config/i3status/config', '${HOME}/.config/i3status/config'],
    ['${PWD}/config/i3blocks/config', '${HOME}/.config/i3blocks/config'],
    ['${PWD}/config/ranger/commands.py', '${HOME}/.config/ranger/commands.py'],
    ['${PWD}/config/ranger/rc.conf', '${HOME}/.config/ranger/rc.conf'],
    ['${PWD}/config/ranger/scope.sh', '${HOME}/.config/ranger/scope.sh'],
    ['${PWD}/config/rofi/config.rasi', '${HOME}/.config/rofi/config.rasi'],
    ['${PWD}/config/qutebrowser/config.py',
        '${HOME}/.config/qutebrowser/config.py'],
    ['${PWD}/config/qutebrowser/solarized.css',
        '${HOME}/.config/qutebrowser/solarized.css'],
    ['${PWD}/config/zathura/zathurarc', '${HOME}/.config/zathura/zathurarc'],
    ['${PWD}/config/xfce4/terminal/accels.scm',
        '${HOME}/.config/xfce4/terminal/accels.scm'],
    ['${PWD}/ctags', '${HOME}/.ctags'],
    ['${PWD}/config/compton/compton.conf',
        '${HOME}/.config/compton/compton.conf'],
    ['${PWD}/config/conky/conky.conf', '${HOME}/.config/conky/conky.conf'],
    ['${PWD}/config/wal/after.sh', '${HOME}/.config/wal/after.sh'],
    ['${PWD}/config/wal/templates/dunstrc',
        '${HOME}/.config/wal/templates/dunstrc'],
    ['${PWD}/config/nyaovim/nyaovimrc.html',
        '${HOME}/.config/nyaovim/nyaovimrc.html'],
    ['${PWD}/hyper.js', '${HOME}/.hyper.js'],
    ['${PWD}/npmrc', '${HOME}/.npmrc'],
    ['${PWD}/config/alacritty/alacritty.yml',
        '${HOME}/.config/alacritty/alacritty.yml'],
    ['${PWD}/vimspector.json', '${HOME}/.vimspector.json'],
    ['${PWD}/atoolrc', '${HOME}/.atoolrc'],
    ['${PWD}/docker/config.json', '${HOME}/.docker/config.json'],
]

lines_for_include = [
    ['source ${PWD}/commonshrc', '${HOME}/.bashrc'],
    ['source ${PWD}/bashrc', '${HOME}/.bashrc'],
    ['source ${PWD}/commonshrc', '${HOME}/.zshrc'],
    ['source ${PWD}/zshrc', '${HOME}/.zshrc'],
    ['source ${PWD}/zshenv', '${HOME}/.zshenv'],
    ['source-file ${PWD}/tmux.conf', '${HOME}/.tmux.conf'],
    ['source ${PWD}/vimrc', '${HOME}/.vimrc'],
    ['source ${PWD}/config/nvim/init.vim', '${HOME}/.config/nvim/init.vim'],
    ['source ${PWD}/profile', '${HOME}/.profile'],
]


def mkdir(path):
    os.makedirs(os.path.expandvars(path), exist_ok=True)


def symlink(src, dest, verbose=False):
    src = os.path.expandvars(src)
    dest = os.path.expandvars(dest)
    if verbose:
        print('create link: {} -> {}'.format(src, dest))

    # create directory for dest
    mkdir(os.path.dirname(dest))

    if os.path.exists(dest):
        if os.path.islink(dest):
            # remove old link
            os.remove(dest)
        else:
            print('{} is already exists'.format(dest))
            print('Backup original and replace? [y/N]')
            ans = input()
            if not ans.upper().startswith('Y'):
                print('skip')
                return
            else:
                os.rename(dest, dest + '.old')

    os.symlink(src, dest)


def add_line_if_not_contained(line, filename, verbose=False):
    line = os.path.expandvars(line)
    filename = os.path.expandvars(filename)
    contents = []

    if verbose:
        print('add line to file: "{}" to {}'.format(line, filename))
    should_add_line = False

    if os.path.exists(filename):
        with open(filename, encoding='utf-8') as f:
            contents = f.readlines()
            contents = [content.rstrip() for content in contents]
            if line.strip() not in contents:
                contents.append(line)
                should_add_line = True
    else:
        should_add_line = True
        mkdir(os.path.dirname(filename))

    if should_add_line:
        with open(filename, 'a', encoding='utf-8') as f:
            f.write('\n{}\n'.format(line))



if __name__ == "__main__":
    for src, dest in links:
        symlink(src, dest, verbose=True)

    for line, filename in lines_for_include:
        add_line_if_not_contained(line, filename, verbose=True)
