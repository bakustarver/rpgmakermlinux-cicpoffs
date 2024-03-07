#!/bin/bash

archt=$(uname -m)
link="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/v1.0.0/rpgmakerlinux-$archt-v1.0.0.tar.gz"
basenametar=$(basename "$link")
dirtarname=$(echo "$basenametar" | sed -e 's@.tar.gz@@g')
wget -P "/tmp/" "$link"
tar -xf "/tmp/nwjs-$version-linux-$arch.tar.gz" -C "/tmp/"
rm "/tmp/$basenametar"
/tmp/$dirtarname/install.sh
