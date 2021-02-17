#!/bin/bash

# バッテリーが残り20分以下になると通知を表示するスクリプト
# 参考: https://faq.i3wm.org/question/1730/warning-popup-when-battery-very-low.1.html

while true; do
    BATTINFO=$(acpi -b)
    # shellcheck disable=SC2143
    if [[ $(echo "$BATTINFO" | grep Discharging) && $(echo "$BATTINFO" | cut -f 5 -d ' ') < 00:20:00 ]] ; then
        DISPLAY=:0.0 /usr/bin/notify-send "low battery" "$BATTINFO"
    fi
    sleep 5m
done
