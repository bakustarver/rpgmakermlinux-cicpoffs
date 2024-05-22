#!/bin/bash




rm -rf "$HOME/desktopapps/nwjs" && rm "$HOME/.local/share/applications/nwjstest.desktop" && rm "$HOME/.local/share/applications/nwjsoptions.desktop" && rm "$HOME/.local/bin/rpgmaker-linux" && rm -rf "$HOME/.steam/steam/compatibilitytools.d/rpgmaker-linux-cicpoffs"
sed -e 's@x-scheme-handler/rpgmakermp.*@@g' -i /home/pasha/.config/mimeapps.list
