#!/bin/bash


mainfd="$HOME/desktopapps/nwjs"
localapplicationsfd="$HOME/.local/share/applications/"
localbin="$HOME/.local/bin"


rm -rf "$mainfd"
rm "$localapplicationsfd/nwjstest.desktop"
rm "$localapplicationsfd/nwjsoptions.desktop"
rm "$localbin/rpgmaker-linux"
rm -rf "$HOME/.local/share/Steam/compatibilitytools.d/rpgmaker-linux-steam-wrapper/"
rm -rf "$HOME/.var/app/com.valvesoftware.Steam/data/Steam/compatibilitytools.d/rpgmaker-linux-steam-wrapper/"

sed -e 's@x-scheme-handler/rpgmakermp.*@@g' -i "$HOME/.config/mimeapps.list"
