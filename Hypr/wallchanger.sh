#!/bin/bash
directory="/home/lodvald/Documents/Wallpapers/"

if [ -d "$directory" ]; then
	random_background="$(ls $directory/* | shuf -n 1)"
	display_engine="$(awk -F'=' '/^backend =/ {print$2}' ~/.config/waypaper/config.ini | xargs)"
	echo "got the engine >$display_engine<"
	
	if [ "$display_engine" = "hyprpaper" ]; then
		echo "$display_engine <---should be hyprpaper"
		hyprctl hyprpaper unload all
		hyprctl hyprpaper preload $random_background
		hyprctl hyprpaper wallpaper "eDP-1,contain:$random_background"
	elif [ "$display_engine" = "swww" ]; then
		echo "$display_engine <---should be swww"
		swww img -t simple $random_background
	fi
fi

