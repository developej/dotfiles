setxkbmap -layout "us, rs(latin), rs" -option "grp:shift_toggle"
/usr/bin/setxkbmap -option "ctrl:swapcaps"
/usr/bin/start-pulseaudio-x11

xset -dpms

exec i3
