#!/bin/bash

# i3-msg -t get_tree | jq 'recurse(.name?)|.name'
# i3-msg -t get_tree|jq '..|select(.name?)|select(.type=="con")|select(.name!="content")|{name, type}'

get_window_names() {
    # windowがnullじゃないノードのnameを取得
    # i3barは除く
    i3-msg -t get_tree|jq -r '..|select(.window?)|select(.window_properties.class!="i3bar")|.name'
}

get_focused_window_name() {
    # focusedがtrueのノードのnameを取得
    i3-msg -t get_tree|jq -r '..|select(.focused?==true)|.name'
}

rename_workspace() {
    new_workspace_name=$(zenity --entry --width=400 --title="Rename Window" --text="Input new workspace name.")
    i3-msg rename workspace to $new_workspace_name
}

#!/bin/bash

win_name=$(xdotool getactivewindow getwindowname)

msg(){
    echo $1
}

dispatch_command(){
    # echo $win_name
    case $win_name in
        *Terminal* ) msg term ;;
        *Google\ Chrome* ) echo google ;;
    esac
}

packages=(
    "aa"
    "bb"
    "cc"
    "ddd"
)
packages[0]=ok
packages[1]=on

# get_window_names
# get_focused_window_name
# rename_workspace
IFS=':'
echo ${packages[*]}
