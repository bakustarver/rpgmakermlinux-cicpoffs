#!/bin/bash

gitlink="https://github.com/nwjs/nw.js"
# defp="$HOME/desktopapps/nwjs/nwjs"
if [ -z "$defpn" ]; then
defpn=$(dirname "$0")
else
defp="$defpn"
fi
# kdialog --msgbox "$test $depfp"
# defp="$defp0/nwjs"
# echo "defp $defp"
if ! [ -d "$defp" ]; then
mkdir -p "$defp"
fi;

nwjslist=$(ls -p "$defp/nwjs" | grep /)
if [ -n "$mainfd" ]; then
nwjsfm="$mainfd/nwjs/nwjs"
else
nwjsfm="$HOME/desktopapps/nwjs/nwjs"
fi

if [ -f "$nwjsfm/packagefiles/usesdk.txt" ]; then
SDKNWJS=true
nwjslist=$(echo "$nwjslist" | grep "sdk")
else
nwjslist=$(echo "$nwjslist" | grep -v "sdk")
fi
if [ -z "$DWNWJSNODEBUG" ]; then
echo "$SDKNWJS"
fi
versioninstalledlist=$(ls "$defp")
arch=$(uname -m | sed -e 's@i686@ia32@g' -e 's@x86_64@x64@g' -e 's@armv7l@armhf@g' -e 's@armhf@arm@g' -e 's@aarch64@arm64@g')




downloadversion() {
if [ -n "$SDKNWJS" ]; then
file="nwjs-sdk-$version-linux-$arch.tar.gz"
else
file="nwjs-$version-linux-$arch.tar.gz"
fi
link="https://dl.nwjs.io/$version/$file"

if wget -q --spider "$link"; then
wget -c -P "$defp" "$link"

tar -xf "$defp/$file" -C "$defp/nwjs"
rm "$defp/$file"
else
echo "Can't find such version "
fi
}


downloadandextract() {

if [ -n "$nwjslinktar" ]; then
tar -xf "$defp/nwjs-$version-linux-$arch.tar.gz" -C "$defp/nwjs"
rm "$defp/nwjs-$version-linux-$arch.tar.gz"
echo Finished
fi

}


if [ "$arch" = "arm" ]; then
if [ -n "$SDKNWJS" ]; then
echo "No sdk version for your architecture $arch
Use $ rpgmaker-linux --usestandart";
exit
fi
nwjslinktar="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/libraries/nwjs-v0.60.1-linux-arm.tar.gz"
downloadandextract
elif [ "$arch" = "arm64" ]; then
if [ -n "$SDKNWJS" ]; then
echo "There is no sdk version for your architecture $arch
Use $ rpgmaker-linux --usestandart";
exit;
fi
nwjslinktar="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/libraries/nwjs-v0.60.1-linux-arm64.tar.gz"
downloadandextract
fi
#get latest nwjs version info
if [ "$arch" = "x64" ] || [ "$arch" = "ia32" ]; then

if [ -z "$@" ]; then
version=$(wget --user-agent 'Mozilla/5.0 (Windows NT 10.0; rv:124.0) Gecko/20100101 Firefox/124.0' -qO- "https://github.com/nwjs/nw.js/tags" | grep 'Link--primary Link' | head -n 1 | sed -e 's@.*">@@g' -e 's@<.*@@g' -e 's@nw-@@g')
echo "latest version is $version"
else
if echo "$@" | grep -q "v[0-9].[0-9][0-9].[0-9]"; then
version="$@"
elif echo "$@" | grep -q "[0-9].[0-9][0-9].[0-9]"; then
version="v$@"
elif echo "$@" | grep -q "v[0-9].[0-9][0-9][0-9].[0-9]"; then
version="$@"
elif echo "$@" | grep -q "[0-9].[0-9][0-9][0-9].[0-9]"; then
version="v$@"
else
echo "Incorrect version name - $@"
exit 1;
fi


fi
# kdialog --msgbox "hello 1"


# echo "$latestlocal $version"
if [ -n "$latestlocal" ] && [ "$latestlocal" = "$version" ] && [ -z "$checkversionnwjs" ]; then
echo Your nwjs version is latest
echo Reinstall? y/n
read
if [ "$REPLY" = "y" ] || [ "$REPLY" = "yes" ]; then
if [ -n "$SDKNWJS" ]; then
rm -rf "$defp/nwjs/nwjs-sdk-$version-linux-x64/"
else
rm -rf "$defp/nwjs/nwjs-$version-linux-x64/"
fi
echo Reinstalling "$latestlocal";
# fi
else
exit;
fi
fi


# uname -p
# echo "sdk q$SDKNWJS"

if [ "$skipdownloadifexist" = "true" ]; then
# if  "$nwjslist"
if [ -n "$nwjslist" ] && echo "$nwjslist" | grep -q "$version" ; then

# version
if [ -z "$DWNWJSNODEBUG" ]; then
echo skiping
fi
else
downloadversion
fi
# echo skipping download;
else
downloadversion
fi
echo Finished
fi
# fi
