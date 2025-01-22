#!/bin/bash

archt=$(uname -m | sed -e 's/armv7l/armhf/g')
version=1.1.5

ITCHIOFILEPATH="$HOME/.config/itchiokey.txt"

if [ -f "$ITCHIOFILEPATH" ] && [ -s "$ITCHIOFILEPATH" ]; then
ITCH_API_KEY=$(cat "$ITCHIOFILEPATH")
fi

if [ -n "$ITCH_API_KEY" ]; then
echo "Installing the professional version"
itchjson=$(wget -qO- "https://api.itch.io/games/2577304/uploads?api_key=$ITCH_API_KEY")
if [ -z "$itchjson" ]; then
echo "Cannot get data from server, wrong itch.io key?"
exit 1
fi
itchdata=$(echo "$itchjson" | sed -e 's@"traits"@\n@g' | grep "$archt")
itchid=$(echo "$itchdata" | sed -e 's@.*,"id":@@g' -e 's@,.*@@g')
basenametar=$(echo "$itchdata" | sed -e 's@.*"filename":"@@g' -e 's@".*@@g')
dirtarname=$(echo "$basenametar" | sed -e 's@.tar.gz@@g')
wget "https://api.itch.io/uploads/$itchid/download?api_key=$ITCH_API_KEY" -O "/tmp/$basenametar"

else
echo "Installing the base version"
link="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/v$version/rpgmakerlinux-$archt-v$version.tar.gz"

basenametar=$(basename "$link")
dirtarname=$(echo "$basenametar" | sed -e 's@.tar.gz@@g')
wget -P "/tmp/" "$link"
fi
tar -xf "/tmp/$basenametar" -C "/tmp/"
# rm "/tmp/$basenametar"
/tmp/$dirtarname/install.sh
