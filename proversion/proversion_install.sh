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
apikey=$(/tmp/yad --entry --entry-label="Your itch io api key" --title="Pro version installer")
gui=true
else
apikey=$(echo "$@")
fi


jsondata=$(wget -qO- "https://api.itch.io/games/2577304/uploads?api_key=$apikey")

if [ -z "$itchjson" ]; then
if [ "$gui" = "true" ]; then
/tmp/yad --text "Cannot get data from server, wrong itch.io key?"
# else
fi
echo "Cannot get data from server, wrong itch.io key?"
exit 1
else
echo "$apikey" > "$ITCHIOFILEPATH"
fi

export ITCH_API_KEY="$apikey"


wget -qO- "https://raw.githubusercontent.com/bakustarver/rpgmakermlinux-cicpoffs/main/installgithub.sh" | bash

