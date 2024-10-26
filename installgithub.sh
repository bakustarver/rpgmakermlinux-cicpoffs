#!/bin/bash

archt=$(uname -m | sed -e 's/armv7l/armhf/g')
version=1.1.3
link="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/v$version/rpgmakerlinux-$archt-v$version.tar.gz"
basenametar=$(basename "$link")
dirtarname=$(echo "$basenametar" | sed -e 's@.tar.gz@@g')
wget -P "/tmp/" "$link"
tar -xf "/tmp/$basenametar" -C "/tmp/"
rm "/tmp/$basenametar"
/tmp/$dirtarname/install.sh
