#!/bin/bash




mainfdf="$HOME/.config/defrpgmakerlinuxpath.txt"
if [ -f "$mainfdf" ] && [ -s "$mainfdf" ]; then
mainfd=$(cat "$mainfdf")
if [ -d "$mainfd" ] && [ -n "$mainfd" ]; then
rm -rf "$mainfd/desktopapps/";
fi
else
rm -rf "$HOME/desktopapps/";
firm "$HOME/.local/share/applications/nwjstest.desktop";
rm "$HOME/.local/share/applications/nwjsoptions.desktop";
rm "$HOME/.local/bin/rpgmaker-linux";
rm -rf "$HOME/.local/share/Steam/compatibilitytools.d/rpgmaker-linux-steam-wrapper/";
rm -rf "$HOME/.var/app/com.valvesoftware.Steam/data/Steam/compatibilitytools.d/rpgmaker-linux-steam-wrapper/"
sed -e 's@x-scheme-handler/rpgmakermp.*@@g' -i "$HOME/.config/mimeapps.list"
