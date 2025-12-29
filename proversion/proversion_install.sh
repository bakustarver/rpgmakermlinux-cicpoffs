#!/bin/bash



ITCHIOFILEPATH="$HOME/.config/itchiokey.txt"


arch=$(uname -m)



yadinstall() {
wget "https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/libraries/yad.$arch" -O /tmp/yad
chmod +x /tmp/yad

}



if [ -z "$@" ]; then
if ! [ -f "/tmp/yad" ]; then
yadinstall
fi
apikey=$(/tmp/yad --width=600 --entry --entry-label="Your itch io api key" --title="Pro version installer")
gui=true
else
apikey=$(echo "$@")
fi


export ITCH_API_KEY="$apikey"


wget -qO- "https://raw.githubusercontent.com/bakustarver/rpgmakermlinux-cicpoffs/main/installgithub.sh" | bash

