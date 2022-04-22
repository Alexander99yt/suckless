#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Keyboard Layout
setxkbmap es &

# Display Resolution
#xrandr --output Virtual-1 --mode 1920x1080 &
#xrandr --output HDMI-1 --mode 1366x768 --left-of DP-2 --output DP-2 --mode 1920x1080 --rate 144
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# RGB Lights
#exec /opt/OpenRGB/OpenRGB --profile xd.orp
exec openrgb -m 'Spectrum Cycle' &

# Razer Devices
#! /bin/bash
sleep 4
polychromatic-cli -d mouse --dpi 354
polychromatic-cli -d mouse -o wave -p 2
polychromatic-cli -d keyboard -o wave -p 1

# Compositor
#picom -f &

# Wallpaper
nitrogen --restore &

# Status bar loop
slstatus &

# Java blank window bug
export _JAVA_AWT_WM_NONREPARENTING=1

#GTK Theme
export GTK_THEME=Adapta:dark

# Use Kvantum for qt
export QT_STYLE_OVERRIDE=kvantum

# Execute dwm
exec dwm


