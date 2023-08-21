# NightModeExtender
This script automatically extends the changes in theme when the dark mode is enabled. It checks the status of that switch every 15 minutes.

It is possible to customize a light theme and a dark theme indipendently for the user interface in GNOME. It is also possible to set other light and dark themes for specific applications.

## Installation
Download the archive and unpack it. `cd` into the uncompressed folder and give the following command from the terminal:

`$ chmod +x NightModeExtender.sh ; mv NightModeExtender.sh ~/.NightModeExtender.sh ; mv NightModeExtender.desktop ~/.config/autostart/`

Then reboot.

## Set custom themes
Open the script `.NightModeExtender.sh` and set the name of your favourite themes in the first lines.

## PAY ATTENTION!
Some apps like Libreoffice overwrites the changes set by this script if they're open when the dark mode is enabled.

## Credits
JustPerfection is the original author of the script that I slightly edited. I really really really want to thank him for his help and availability. THANK YOU, JUSTPY!
