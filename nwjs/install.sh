#!/bin/bash

installpath=$(dirname "$0")
version='1.1.0'
if ! [ -d "$installpath/nwjs" ]; then
echo "Can't find nwjs folder"
exit 1;
fi
echo "Installing rpgmaker-linux v$version"

mainfdtxt="$HOME/.config/defrpgmakerlinuxpath.txt"
if [ -e "$mainfdtxt" ]; then
mainfd=$(cat "$mainfdtxt" | sed -e 's@/$@@g' -e 's@$@/nwjs@g');
mainfde=$(cat "$mainfdtxt" | sed -e 's@/$@@g')
customrpgmakerlinuxpath=true
else
mainfd="$HOME/desktopapps/nwjs"
fi
localapplicationsfd="$HOME/.local/share/applications"
localbin="$HOME/.local/bin"
compatibilitytoolsfddef="$HOME/.steam/root/compatibilitytools.d/"
compatibilitytoolsfdflatpak="$HOME/.var/app/com.valvesoftware.Steam/data/Steam/compatibilitytools.d/"

arch=$(uname -m)
archcheckmessage=$(echo "$arch" | sed -e 's@x86_64@, x86-64, version@g' -e 's@aarch64@, ARM aarch64,@g' -e 's@i686@, Intel 80386,@g' -e 's@i386@, Intel 80386,@g' -e 's@armv7l@, ARM,@g' -e 's@armhf@, ARM,@g')

rm -rf "$mainfd"


createfd() {
if ! [ -d "$1" ]; then
echo "Missing $1 creating one"
mkdir -p "$1"
if [ "$1" = "$localbin" ]; then
nolocalbin=true
fi
fi;
}

rmfd() {
if [ -d "$1" ]; then
rm -rf "$1"
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

steamcompatibilitytoolinstaller() {

createfd "$1"
rmfd "$1/rpgmaker-linux-steam-wrapper"
cp -r "$installpath/nwjs/packagefiles/rpgmaker-linux-steam-wrapper/" "$1"

}

if ! file "$1" | grep -q "$archcheckmessage" ; then
# Use $ wget -qO- installscript.sh | bash
file "$1"
echo "Wrong architecture!!
Download corrent archive with $arch"
exit 1;
fi
}

createfd "$mainfd"
createfd "$localapplicationsfd"
createfd "$localbin"


checkthebinaryarch "$installpath/nwjs/cicpoffs"
cp "$installpath/install.sh" "$mainfd"
cp "$installpath/uninstall.sh" "$mainfd"

cp -r "$installpath/nwjs" "$mainfd"

if [ "$customrpgmakerlinuxpath" = "true" ]; then
sed "s@^mainfd=.*@mainfd=\"$mainfde\"@g" -i "$mainfd/nwjs/packagefiles/nwjsstart-cicpoffs.sh"
fi

# echo "Making a desktop file"
echo -e "[Desktop Entry]
Name=RPG Maker MV/MZ (cicpoffs mount)
Exec=env gamef=\"%u\" $mainfd/nwjs/packagefiles/nwjsstart-cicpoffs.sh --chooselatestnwjs
Type=Application
Categories=Games
StartupNotify=true
MimeType=application/x-ms-dos-executable;application/x-wine-extension-msp;
Icon=$mainfd/nwjs/packagefiles/nwjs128.png
Terminal=true
NoDisplay=true" > "$localapplicationsfd/nwjstest.desktop"
chmod +x "$localapplicationsfd/nwjstest.desktop"

echo -e "[Desktop Entry]
Name=RPG Maker MV/MZ Options
Exec=env gamef=\"%u\" $mainfd/nwjs/packagefiles/nwjsstart-cicpoffs.sh --gui
Type=Application
Categories=Games
StartupNotify=true
MimeType=application/x-ms-dos-executable;application/x-wine-extension-msp;x-scheme-handler/rpgmakermp
Icon=$mainfd/nwjs/packagefiles/nwjs128.png
Terminal=true
NoDisplay=true" > "$localapplicationsfd/nwjsoptions.desktop"
chmod +x "$localapplicationsfd/nwjsoptions.desktop"


lnnew "$mainfd/nwjs/packagefiles/nwjsstart-cicpoffs.sh" "$localbin/rpgmaker-linux"
chmod +x "$localbin/rpgmaker-linux"
update-desktop-database -q ~/.local/share/applications
xdg-mime default nwjsoptions.desktop x-scheme-handler/rpgmakermp
echo "Installation Done"



if [ -d "$HOME/.steam/" ]; then
steamcompatibilitytoolinstaller "$compatibilitytoolsfddef"
fi

if [ -d "$HOME/.var/app/com.valvesoftware.Steam/data/Steam" ]; then
steamcompatibilitytoolinstaller "$compatibilitytoolsfdflatpak"
fi

if [ -n "$nolocalbin" ]; then
echo "$localbin folder was created, you might need to restart your computer if you want to use the program in the terminal
Or use
$ export PATH=\$PATH:$localbin"
fi
