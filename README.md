# JustAPerfectTheme
Automatically change the theme from light to dark if the night-mode is enabled in GNOME. It can also change the gedit theme to make it more readable at night.

## Installation
Download the files and give the following command from the terminal:

`$ chmod +x .JustTheme.sh ; mv .JustTheme.sh ~ ; mv JustTheme.desktop ~/.config/autostart/`

## Set custom themes
Open the script `.JustTheme.sh` and set the name of your favourite themes in the first lines.

## PAY ATTENTION!
Some apps like Libreoffice overwrites the changes set by this script if they're open when the sunset/sunrise happens. The script will keep forcing an icon theme change every 5 minutes. In order to let it set the change, Libreoffice must be closed for at least 5 minutes.

## Credits
JustPerfection is the original author of the script that I slightly edited. I really really really want to thank him for his help and availability. THANK YOU, JUSTPY!
