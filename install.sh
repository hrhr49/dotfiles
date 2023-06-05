#!/usr/bin/env bash
set -e
# change directory to the location of this script
cd "$(dirname "$0")" || exit

if [ "$1" = "overwrite" ]; then
  manual=false
else
  manual=true
fi

create_symlink() {
  src="$1"
  dst="$2"
  mkdir -p "$(dirname "$dst")"

  if "$manual" && [ -f "$dst" ] && [ ! -L "$dst" ]; then
    echo "\"$dst\" already exists."
    read -r -p "backup original file and replace? (y/N): " yn
    case "$yn" in
      [yY]*) cp "$dst" "${dst}.org"
             ln -snvf "$src" "$dst" ;;
      *)     echo "cancel" ;;
    esac
  else
   ln -snvf "$src" "$dst"
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
files=(
  xinitrc
  xprofile
  Xresources
  profile
  ctags
  hyper.js
  npmrc
  vimspector.json
  atoolrc
  tmux.conf
  vimrc
  bashrc
  zshrc
  commonshrc
  yabairc
  skhdrc
  hammerspoon
)
for file in "${files[@]}"
do
  create_symlink "${PWD}/${file}" "${HOME}/.${file}"
done
create_symlink "${PWD}/scripts" "${HOME}/bin/scripts"

# # なぜかディレクトリでシンボリックリンクしないとうまく行かない？
# rm -rf "${HOME}/.easystroke"
# ln -snvf "${PWD}/easystroke" "${HOME}/.easystroke"

# root権限が必要なのでひとまず保留
# create_symlink "${PWD}/90-libinput.conf" "/etc/X11/xorg.conf.d/90-libinput.conf"
