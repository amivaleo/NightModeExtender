#!/bin/bash

# leave it empty if you want to use adwaita theme
gnome_theme_light="Adwaita";
gnome_theme_dark="Adwaita-dark";
gedit_theme_light="classic";
gedit_theme_dark="oblivion";

# default values
lastmonth=0;
lastday=0;
currentdday=$(date +%d);
currentmonth=$(date +%m);
currenttime=$(date +%H:%M:%S);

while true; do 
	
	if [[ "$gnome_theme_light" == "" ]] || [[ "$gnome_theme_dark" == "" ]]; then
		gnome_theme_light="Adwaita";
		gnome_theme_dark="Adwaita-dark";
	fi
	
	if [[ "$lastmonth" != "$currentmonth" ]] && [[ "$lastday" != "$currentday" ]]; then
		lastmonth="$currentmonth";
		lastday="$currentday";
		
		get="$(curl -s "http://ip-api.com/json")";
		lon=$(echo $get | jq -r '.lon');
		lat=$(echo $get | jq -r '.lat');

		get2="$(curl -s "https://api.sunrise-sunset.org/json?lat=$lat&lng=$lon&formatted=0")";
		sunrise=$(echo $get2 | jq -r '.results.sunrise');
		sunset=$(echo $get2 | jq -r '.results.sunset');
		sunrise="$(echo $sunrise |grep -Eo '[[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2}')";
		sunset="$(echo $sunset |grep -Eo '[[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2}')";
	fi
	
	if [[ "$currenttime" > "$sunset" ]] || [[ "$currenttime" < "$sunrise" ]]; then
		$( gsettings set org.gnome.desktop.interface gtk-theme "$gnome_theme_dark" );
		$( gsettings set org.gnome.gedit.preferences.editor scheme "$gedit_theme_dark" );
	else
		$( gsettings set org.gnome.desktop.interface gtk-theme "$gnome_theme_light" );
		$( gsettings set org.gnome.gedit.preferences.editor scheme "$gedit_theme_light" );
	fi
	
	sleep 300;
	
done
