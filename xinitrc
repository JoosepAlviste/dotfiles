# Load xresources including customizations
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Keyboard layout
setxkbmap -layout us,ee -option 'grp:shifts_toggle'
# Load keys
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
xbindkeys

# Start our window manager
exec i3

