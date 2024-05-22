#!/bin/bash




rm -rf "$HOME/desktopapps/nwjs" && rm "$HOME/.local/share/applications/nwjstest.desktop" && rm "$HOME/.local/share/applications/nwjsoptions.desktop" && rm "$HOME/.local/bin/rpgmaker-linux" && rm -rf "$HOME/.local/share/Steam/compatibilitytools.d/rpgmaker-linux-steam-wrapper/" && rm -rf "$HOME/.var/app/com.valvesoftware.Steam/data/Steam/compatibilitytools.d/rpgmaker-linux-steam-wrapper/"
sed -e 's@x-scheme-handler/rpgmakermp.*@@g' -i /home/pasha/.config/mimeapps.list
