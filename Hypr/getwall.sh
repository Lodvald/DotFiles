#!/bin/bash
#need to check if the folder is not empty first and then
#removes all the files from the cached wallpaper folder
if [ "$(ls -A ~/.cache/CurrentWallpaper/)" ]; then
	rm ~/.cache/CurrentWallpaper/*
fi

#get the current "wallpaper engine"
display_engine="$(awk -F'=' '/^backend =/ {print$2}' ~/.config/waypaper/config.ini | xargs)"

#get the current wallpaper
if [ "$display_engine" = "hyprpaper" ]; then
	current="$(hyprctl hyprpaper listactive)"
	echo done with hyprpaper
	echo $current
elif [ "$display_engine" = "swww" ]; then
	current="$(swww query | awk -F'currently displaying: image:' '{print$2}' | xargs)"
	echo done with swww
	echo $current
fi
#set the address that contains the wallpaper
b="${current##*/}"
echo $b
w="/home/lodvald/Documents/Wallpapers/$b"
echo $w
#copies the current wallpaper to the .cache/CurrentWallpaper folder
cp $w ~/.cache/CurrentWallpaper/
mv ~/.cache/CurrentWallpaper/$b ~/.cache/CurrentWallpaper/image.png
hyprlock
