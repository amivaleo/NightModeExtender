#!/bin/bash

# edit the following to set different themes and variants
gnome_theme_light="Adwaita";
gnome_theme_dark="Adwaita-dark";
gedit_theme_light="classic";
gedit_theme_dark="oblivion";


file=".config/autostart/JustTheme.desktop";
if [ ! -f "$file" ]; then
	touch $file;
	echo $'[Desktop Entry]\nType=Application\nExec=~/.JustTheme.sh\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName[en]=JusTheme\nName=JusTheme\nComment[en]=JusTheme\nComment=JusTheme' >> $file;
fi

while true; do

	clear;
	
	nightmode="$(gsettings get org.gnome.settings-daemon.plugins.color night-light-enabled)";
	
	if [ "$nightmode" == "true" ]; then
		$( gsettings set org.gnome.desktop.interface gtk-theme "$gnome_theme_dark" );
		$( gsettings set org.gnome.gedit.preferences.editor scheme "$gedit_theme_dark" );
	else
		$( gsettings set org.gnome.desktop.interface gtk-theme "$gnome_theme_light" );
		$( gsettings set org.gnome.gedit.preferences.editor scheme "$gedit_theme_light" );
	fi
	
	sleep 300;

done
