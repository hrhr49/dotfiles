packages=(
    rofi
    fzf
    otf-ipafont
    adobe-source-han-sans-jp-fonts
    alacritty
    zsh
    vim
    neovim
    tmux
    git
    w3m
    imagemagick
    sxiv
    zathura
    mpv
    xfce4-terminal
    zenity
    xdotool
    dunst
    scrot
    xclip
    aria2
    pigz
    entr
    feh
    compton
    nodejs
    npm
    ruby
    chromium

    fcitx-mozc
    fcitx-gtk2
    fcitx-gtk3
    fcitx-qt5
    fcitx-im

    unzip
)

if type "pacman" > /dev/null 2>&1; then
    sudo pacman -S "${packages[@]}"
fi
