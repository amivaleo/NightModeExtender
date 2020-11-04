#!/bin/bash

# leave it empty if you want to use adwaita theme
gnome_theme_light="Adwaita-Light";
gnome_theme_dark="Adwaita-Dark";
gedit_theme_light="classic";
gedit_theme_dark="oblivion";
gimp_theme_light="Symbolic-Inverted";
gimp_theme_dark="Symbolic";
libreoffice_theme_light="sifr";
libreoffice_theme_dark="sifr_dark";
gnome_latex_theme_light="classic";
gnome_latex_theme_dark="oblivion";

# default values
lastmonth=0;
lastday=0;

# check internet connection
wget -q --spider http://google.com

# if online 
if [ $? -eq 0 ]; then

	while true; do 
		
		currentdday=$(date -u +%d);
		currentmonth=$(date -u +%m);
		
		if [[ "$lastmonth" != "$currentmonth" ]] || [[ "$lastday" != "$currentday" ]]; then
	#		notify-send -i "SUMMARY" "$lastmonth $currentmonth - $lastday $currentday";
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
		
		currenttime=$(date -u +%H:%M:%S);
		currenttheme=$(gsettings get org.gnome.desktop.interface gtk-theme);
		
		echo sunset = $sunset
		echo currenttime = $currenttime
		echo sunrise = $sunrise
		
		# during the day:
		if [[ "$sunrise" < "$currenttime" ]] && [[ "$currenttime" > "$sunset" ]] ; then

			if [[ "$currenttheme" != "'$gnome_theme_light'" ]]; then
				$( gsettings set org.gnome.desktop.interface gtk-theme "$gnome_theme_light" );
				$( gsettings set org.gnome.gedit.preferences.editor scheme "$gedit_theme_light" );
				$( gsettings set org.gnome.gnome-latex.preferences.editor scheme "$gnome_latex_theme_light" );
				
				echo "0" | sudo tee /sys/devices/platform/dell-laptop/leds/dell::kbd_backlight/brightness > /dev/null;
				sed -i '/SymbolStyle/c\<item oor:path="/org.openoffice.Office.Common/Misc"><prop oor:name="SymbolStyle" oor:op="fuse"><value>'$libreoffice_theme_light'</value></prop></item>' ~/.var/app/org.libreoffice.LibreOffice/config/libreoffice/4/user/registrymodifications.xcu
				
				if [[ "$(grep "icon-theme" ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc)" ]]; then
					sed -i '/(icon-theme/c\(icon-theme "'$gimp_theme_light'")' ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc
				else
					sed -i 's/(icon-size/(icon-theme "'$gimp_theme_light'")\n(icon-size/g' ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc
				fi
			fi
		
		# during the day
		else

			if [[ "$currenttheme" != "$gnome_theme_dark" ]]; then
				$( gsettings set org.gnome.desktop.interface gtk-theme "$gnome_theme_dark" );
				$( gsettings set org.gnome.gedit.preferences.editor scheme "$gedit_theme_dark" );
				$( gsettings set org.gnome.gnome-latex.preferences.editor scheme "$gnome_latex_theme_dark" );
				
				echo "1" | sudo tee /sys/devices/platform/dell-laptop/leds/dell::kbd_backlight/brightness > /dev/null;
				sed -i '/SymbolStyle/c\<item oor:path="/org.openoffice.Office.Common/Misc"><prop oor:name="SymbolStyle" oor:op="fuse"><value>'$libreoffice_theme_dark'</value></prop></item>' ~/.var/app/org.libreoffice.LibreOffice/config/libreoffice/4/user/registrymodifications.xcu
				
				if [[ "$(grep "icon-theme" ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc)" ]]; then
					sed -i '/(icon-theme/c\(icon-theme "'$gimp_theme_dark'")' ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc
				else
					sed -i 's/(icon-size/(icon-theme "'$gimp_theme_dark'")\n(icon-size/g' ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc
				fi
			fi

		fi
		
		sleep 100;

	done

# if offline
else
	$( gsettings set org.gnome.desktop.interface gtk-theme "$gnome_theme_light" );
	$( gsettings set org.gnome.gedit.preferences.editor scheme "$gedit_theme_light" );
	$( gsettings set org.gnome.gnome-latex.preferences.editor scheme "$gnome_latex_theme_light" );
	
	sed -i '/SymbolStyle/c\<item oor:path="/org.openoffice.Office.Common/Misc"><prop oor:name="SymbolStyle" oor:op="fuse"><value>'$libreoffice_theme_light'</value></prop></item>' ~/.var/app/org.libreoffice.LibreOffice/config/libreoffice/4/user/registrymodifications.xcu

	if [[ "$(grep "icon-theme" ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc)" ]]; then
		sed -i '/(icon-theme/c\(icon-theme "'$gimp_theme_light'")' ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc
	else
		sed -i 's/(icon-size/(icon-theme "'$gimp_theme_light'")\n(icon-size/g' ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc
	fi
fi
