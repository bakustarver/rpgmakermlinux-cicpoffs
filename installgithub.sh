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
itchlinksurl="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/libraries/itchlinks.$archt"
wget "$itchlinksurl" -O "/tmp/itchlinks"
chmod +x "/tmp/itchlinks"
itchlinks=$(/tmp/itchlinks https://bakurpg.itch.io/rpg-maker-mv-mz-for-linux)
if echo "$itchlinks" | grep -q "Client Error"; then 
echo "Cannot get data from server, wrong itch.io key?"
exit 1
fi
savekey "$ITCH_API_KEY"
rpgmprotardata=$(echo "$itchlinks" | grep "$archt")
rpgmprotarurl=$(echo "$rpgmprotardata" | sed -e 's@.*-> @@g')
basenametar=$(echo "$rpgmprotardata" | sed -e 's@ ->.*@@g')
wget "$rpgmprotarurl" -O "/tmp/$basenametar"

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
