#!/bin/bash



ITCHIOFILEPATH="$HOME/.config/itchiokey.txt"


arch=$(uname -m)
archt=$(echo "$arch" | sed -e 's/armv7l/armhf/g')



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

if command -v jq >/dev/null 2>&1; then
jq="jq"
else
if ! [ -f "/tmp/jq" ]; then
jqurl="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/libraries/jq.$archt"
wget "$jqurl" -O "/tmp/jq"
chmod +x "/tmp/jq"
jq="/tmp/jq"
fi
fi



list=$(wget  -qO- "https://api.itch.io/profile/owned-keys?api_key=$apikey" )
id=$(echo "$list" | "$jq" -r '.owned_keys[] | select(.game_id==2577304) | .id')
if [ -z "$id" ]; then
if [ "$gui" = "true" ]; then
/tmp/yad --text "Cannot get data from server, wrong itch.io key?"
# else
fi
echo "Cannot get data from server, wrong itch.io key?"
exit 1
fi
export ITCH_API_KEY="$apikey"


wget -qO- "https://raw.githubusercontent.com/bakustarver/rpgmakermlinux-cicpoffs/main/installgithub.sh" | bash

