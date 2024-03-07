#!/bin/bash

installpath=$(dirname "$0")
version="1.0.0"
if ! [ -d "$installpath/nwjs" ]; then
echo "Can't find nwjs folder"
exit 1;
fi
echo "Installing rpgmaker-linux v$version"

mainfd="$HOME/desktopapps/nwjs"
localapplicationsfd="$HOME/.local/share/applications/"
localbin="$HOME/.local/bin"

arch=$(uname -m)
archcheckmessage=$(echo "$arch" | sed -e 's@x86_64@pie executable, x86-64,@g' -e 's@aarch64@pie executable, ARM aarch64,@g' -e 's@i386@pie executable, Intel 80386,@g' -e 's@armhf@pie executable, ARM,@g')

rm -rf "$mainfd"

createfd() {
if ! [ -d "$1" ]; then
echo "Missing $1 creating one"
mkdir -p "$1"
fi;
}

lnnew() {
if ! [ -f "$1" ]; then
echo "Can't find the $1 file"
fi

if [ -h "$2" ]; then
rm "$2"
fi
ln -s "$1" "$2"

}

checkthebinaryarch() {
if ! [ -f "$1" ]; then
echo "Missing file $1"
fi

if ! file "$1" | grep -q "$archcheckmessage" ; then
# Use $ wget -qO- installscript.sh | bash
file "$1"
echo "Wrong architecture!!
Download the correct version of the program with the name rpgmakerlinux-$arch-v1.0.0.tar.gz"
exit 1;
fi
}

createfd "$mainfd"
createfd "$localapplicationsfd"
createfd "$localbin"

checkthebinaryarch "$installpath/nwjs/cicpoffs"
cp "$installpath/install.sh" "$mainfd"
cp -r "$installpath/nwjs/" "$mainfd"

# echo "Making a desktop file"
echo "[Desktop Entry]
Name=RPG Maker MV/MZ (cicpoffs mount)
Exec=$mainfd/nwjs/packagefiles/nwjsstart-cicpoffs.sh --latest
Type=Application
Categories=Game
StartupNotify=true
MimeType=application/x-ms-dos-executable;application/x-wine-extension-msp;
Icon=$mainfd/nwjs/packagefiles/nwjs128.png
Terminal=true
NoDisplay=true" > "$localapplicationsfd/nwjstest.desktop"
chmod +x "$localapplicationsfd/nwjstest.desktop"


lnnew "$mainfd/nwjs/packagefiles/nwjsstart-cicpoffs.sh" "$localbin/rpgmaker-linux"


echo "Installation Done"
