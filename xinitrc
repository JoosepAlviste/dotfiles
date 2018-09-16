# Load xresources including customizations
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Keyboard layout
setxkbmap -layout us,ee -option 'grp:shifts_toggle'
# Load keys
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
xbindkeys

# Run GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Start our window manager
exec i3

