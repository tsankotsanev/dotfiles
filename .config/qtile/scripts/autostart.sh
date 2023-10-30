#!/bin/bash

function run {
	if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null; then
		$@ &
	fi
}

# nightlight
redshift -P -O 3400

# set monitor resolution to and refresh rate
if xrandr | grep "1366x768"; then
	xrandr -s 1366x768 || echo "Cannot set 1366x768 resolution."
elif xrandr | grep "1920x1080"; then
	xrandr --output HDMI-0 --mode 1920x1080 --rate 240 || echo "Cannot set 1920x1080 resolution."
else
	echo "Could not set a resolution."
fi

# mouse sensitivity
xinput --set-prop 9 'libinput Accel Speed' -0.6

# keyboard
setxkbmap -layout "us, bg" -variant ",phonetic" -option "grp:alt_shift_toggle"

# start sxhkd to replace Qtile native key-bindings
run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

# starting utility applications at boot time
run variety &
run nm-applet &
run pamac-tray &
run xfce4-power-manager &
numlockx on &
blueberry-tray &
picom --config $HOME/.config/qtile/scripts/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# starting user applications at boot time
run volumeicon &
# run discord &
nitrogen --restore &
run caffeine -a &
# run spotify &
# run telegram-desktop &
