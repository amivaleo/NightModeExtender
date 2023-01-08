#!/bin/bash

# leave it empty if you want to use adwaita theme
gnome_theme_light="adw-gtk3";
gnome_theme_dark="adw-gtk3-dark";
gimp_theme_light="Symbolic-Inverted";
gimp_theme_dark="Symbolic";
libreoffice_theme_light="sifr";
libreoffice_theme_dark="sifr_dark";

while true; do 
	currenttheme=$(gsettings get org.gnome.desktop.interface gtk-theme);
	nightmode=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-enabled);
	
	# during the night
	if $nightmode; then
		if [[ "$currenttheme" != "$gnome_theme_dark" ]]; then
			$( gsettings set org.gnome.desktop.interface gtk-theme "$gnome_theme_dark" );
			$( gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' );
			
			sed -i '/SymbolStyle/c\<item oor:path="/org.openoffice.Office.Common/Misc"><prop oor:name="SymbolStyle" oor:op="fuse"><value>'$libreoffice_theme_dark'</value></prop></item>' ~/.var/app/org.libreoffice.LibreOffice/config/libreoffice/4/user/registrymodifications.xcu;
			
			if [[ "$(grep "icon-theme" ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc)" ]]; then
				sed -i '/(icon-theme/c\(icon-theme "'$gimp_theme_dark'")' ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc;
			else
				sed -i 's/(icon-size/(icon-theme "'$gimp_theme_dark'")\n(icon-size/g' ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc;
			fi
		fi
	# during the day:
	else
		if [[ "$currenttheme" != "$gnome_theme_light" ]]; then
			$( gsettings set org.gnome.desktop.interface gtk-theme "$gnome_theme_light" );
			$( gsettings set org.gnome.desktop.interface color-scheme 'default' );
			
			sed -i '/SymbolStyle/c\<item oor:path="/org.openoffice.Office.Common/Misc"><prop oor:name="SymbolStyle" oor:op="fuse"><value>'$libreoffice_theme_light'</value></prop></item>' ~/.var/app/org.libreoffice.LibreOffice/config/libreoffice/4/user/registrymodifications.xcu;
			
			if [[ "$(grep "icon-theme" ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc)" ]]; then
				sed -i '/(icon-theme/c\(icon-theme "'$gimp_theme_light'")' ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc;
			else
				sed -i 's/(icon-size/(icon-theme "'$gimp_theme_light'")\n(icon-size/g' ~/.var/app/org.gimp.GIMP/config/GIMP/2.10/gimprc;
			fi
		fi
	fi
	sleep 900;

done
