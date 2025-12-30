#!/bin/bash

archt=$(uname -m | sed -e 's/armv7l/armhf/g')
version=1.1.6
versionpro=1.1.6

ITCHIOFILEPATH="$HOME/.config/itchiokey.txt"

savekey() {
echo "$1" > "$ITCHIOFILEPATH"
}


if [ -f "$ITCHIOFILEPATH" ] && [ -s "$ITCHIOFILEPATH" ]; then
ITCH_API_KEY=$(cat "$ITCHIOFILEPATH")
fi

if [ -n "$ITCH_API_KEY" ]; then
echo "Installing the professional version"
if command -v jq >/dev/null 2>&1; then
jq="jq"
else
jqurl="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/libraries/jq.$archt"
wget "$itchlinksurl" -O "/tmp/jq"
chmod +x "/tmp/jq"
jq="/tmp/jq"
fi
list=$(wget  -qO- "https://api.itch.io/profile/owned-keys?api_key=$ITCH_API_KEY" )
id=$(echo "$list" | "$jq" -r '.owned_keys[] | select(.game_id==2577304) | .id')
if [ -z "$id" ]; then
  echo "Cannot get data from server, wrong itch.io key?"
  exit
fi
savekey "$ITCH_API_KEY"
listtar=$(wget -qO- "https://api.itch.io/games/2577304/uploads?download_key_id=$id&api_key=$ITCH_API_KEY" | "$jq" -r '.uploads[] | "\(.filename)->https://api.itch.io/uploads/\(.id)/download"')
echo "$listtar"

rpgmprotardata=$(echo "$listtar" | grep "$archt")
rpgmprotarurl=$(echo "$rpgmprotardata" | sed -e 's@.*->@@g')
basenametar=$(echo "$rpgmprotardata" | sed -e 's@->.*@@g')



wget "$rpgmprotarurl?download_key_id=$id&api_key=$ITCH_API_KEY" -O "/tmp/$basenametar"

else
echo "Installing the base version"
link="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/v$version/rpgmakerlinux-$archt-v$version.tar.gz"

basenametar=$(basename "$link")
wget -P "/tmp/" "$link"
fi
dirtarname=$(echo "$basenametar" | sed -e 's@.tar.gz@@g')
tar -xf "/tmp/$basenametar" -C "/tmp/"
/tmp/$dirtarname/install.sh
rm "/tmp/$basenametar"
