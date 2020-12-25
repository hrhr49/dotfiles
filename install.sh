#!/usr/bin/env bash
set -eu
# change directory to the location of this script
cd "$(dirname "$0")" || exit

create_symlink() {
  src="$1"
  dst="$2"
  mkdir -p "$(dirname "$dst")"

  should_create_symlink=false
  if [ -f "$dst" ] && [ ! -L "$dst" ]; then
    echo "\"$dst\" already exists."
    read -r -p "backup original file and replace? (y/N): " yn
    case "$yn" in
      [yY]*) cp "$dst" "${dst}.org"
             should_create_symlink=true ;;
      *)     echo "cancel" ;;
    esac
  else
    should_create_symlink=true
  fi

  if "$should_create_symlink"; then
    echo "symlink $src -> $dst"
    ln -snf "$src" "$dst"
  fi
}

add_line_if_not_contained() {
  line="$1"
  file="$2"
  if [ -f "$file" ] && grep -qxF "$line" "$file"; then
    echo "line is already found: \"$line\" in $file"
  else
    echo "add line \"$line\" to $file"
    mkdir -p "$(dirname "$file")"
    echo "$line" >> "$file"
  fi
}

# symlink config to .config
find config -type f | while read -r file_path
do
  create_symlink "${PWD}/${file_path}" "${HOME}/.${file_path}"
done

# other symlinks
create_symlink "${PWD}/xinitrc" "${HOME}/.xinitrc"
create_symlink "${PWD}/xprofile" "${HOME}/.xprofile"
create_symlink "${PWD}/Xresources" "${HOME}/.Xresources"
create_symlink "${PWD}/ctags" "${HOME}/.ctags"
create_symlink "${PWD}/hyper.js" "${HOME}/.hyper.js"
create_symlink "${PWD}/npmrc" "${HOME}/.npmrc"
create_symlink "${PWD}/vimspector.json" "${HOME}/.vimspector.json"
create_symlink "${PWD}/atoolrc" "${HOME}/.atoolrc"
create_symlink "${PWD}/tmux.conf" "${HOME}/.tmux.conf"
create_symlink "${PWD}/scripts" "${HOME}/bin/scripts"

# root権限が必要なのでひとまず保留
# create_symlink "${PWD}/90-libinput.conf" "/etc/X11/xorg.conf.d/90-libinput.conf"

# append line to file
add_line_if_not_contained "source ${PWD}/commonshrc" "${HOME}/.bashrc"
add_line_if_not_contained "source ${PWD}/bashrc" "${HOME}/.bashrc"
add_line_if_not_contained "source ${PWD}/commonshrc" "${HOME}/.zshrc"
add_line_if_not_contained "source ${PWD}/zshrc" "${HOME}/.zshrc"
add_line_if_not_contained "source ${PWD}/zshenv" "${HOME}/.zshenv"
add_line_if_not_contained "source ${PWD}/vimrc" "${HOME}/.vimrc"
add_line_if_not_contained "source ${PWD}/profile" "${HOME}/.profile"
