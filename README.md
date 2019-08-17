# JustAPerfectTheme
This script automatically changes the interface theme at night, according to sunset and sunrise times. Those times are automatically fetched online depending on the user location. They are compared to the current time every 5 minutes.

The script is active in background all the time, but it is asleep for most of the time and performs some checks once every 5 minutes.

It is possible to customize a light theme and a dark theme indipendently for the user interface in GNOME. It is also possible to set other light and dark themes for specific applications like gedit.

## Installation
Download the files and give the following command from the terminal:

`$ chmod +x .JustTheme.sh ; mv .JustTheme.sh ~ ; mv JustTheme.desktop ~/.config/autostart/`

Then reboot.

## Set custom themes
Open the script `.JustTheme.sh` and set the name of your favourite themes in the first lines.

## PAY ATTENTION!
Some apps like Libreoffice overwrites the changes set by this script if they're open when the sunset/sunrise happens. The script will keep forcing an icon theme change every 5 minutes. In order to let it set the change, Libreoffice must be closed for at least 5 minutes.

## Credits
JustPerfection is the original author of the script that I slightly edited. I really really really want to thank him for his help and availability. THANK YOU, JUSTPY!
