#!/bin/sh

# https://superuser.com/questions/1037466/how-to-start-a-systemd-service-after-user-login-and-stop-it-before-user-logout

setxkbmap -option ctrl:nocaps
setxkbmap -option altwin:swap_alt_win

xmodmap -e "keycode 51 = BackSpace"
xmodmap -e "keycode 22 = backslash bar"

xcape -e "Control_L=Escape"
