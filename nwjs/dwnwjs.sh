#!/bin/bash

gitlink="https://github.com/nwjs/nw.js"
defp="$HOME/desktopapps/nwjs/nwjs"
versioninstalledlist=$(ls "$defp/nwjs")
arch=$(uname -m | sed -e 's@i686@ia32@g' -e 's@x86_64@x64@g' -e 's@armhf@arm@g' -e 's@aarch64@arm64@g')



downloadandextract() {

if [ -n "$nwjslinktar" ]; then
tar -xf "$defp/nwjs-$version-linux-$arch.tar.gz" -C "$defp/nwjs"
rm "$defp/nwjs-$version-linux-$arch.tar.gz"
echo Finished
fi

}


if [ "$arch" = "arm" ]; then
nwjslinktar="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/libraries/nwjs-v0.60.1-linux-arm.tar.gz"
downloadandextract
elif [ "$arch" = "arm" ]; then
nwjslinktar="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/libraries/nwjs-v0.60.1-linux-arm64.tar.gz"
downloadandextract
fi
#get latest nwjs version info
if [ "$arch" = "x64" ] || [ "$arch" = "ia32" ]; then

if [ -z "$@" ]; then
version=$(wget --user-agent 'Mozilla/5.0 (Windows NT 10.0; rv:124.0) Gecko/20100101 Firefox/124.0' -qO- "https://github.com/nwjs/nw.js/tags" | grep 'Link--primary Link' | head -n 1 | sed -e 's@.*">@@g' -e 's@<.*@@g' -e 's@nw-@@g')
else
if echo "$@" | grep -q "v[0-1].[0-9][0-9].[0]"; then
version="$@"
elif echo "$@" | grep -q "[0-1].[0-9][0-9].[0]"; then
version="v$@"
else
echo "Incorrect version name - $@"
exit 1;
fi

if echo "$versioninstalledlist" | grep -q "$version" && [ "$skipdownloadifexist" = "true" ]; then
export nwjsversion="nwjs-$version-linux-$arch/"
fi
fi



# echo "$latestlocal $version"
if [ -n "$latestlocal" ] && [ "$latestlocal" = "$version" ]; then
echo Your nwjs version is latest
echo Reinstall? y/n
read
if [ "$REPLY" = "y" ] || [ "$REPLY" = "yes" ]; then
rm -rf "$defp/nwjs/nwjs-$version-linux-x64/"
echo Reinstalling "$latestlocal";
else
exit
fi
fi


# uname -p

if [ "$skipdownloadifexist" = "true" ]; then

echo skipping download;
else
if [ -n "$SDKNWJS" ]; then
wget -P "$defp" https://dl.nwjs.io/$version/nwjs-sdk-$version-linux-$arch.tar.gz

tar -xf "$defp/nwjs-sdk-$version-linux-$arch.tar.gz" -C "$defp/nwjs"
rm "$defp/nwjs-sdk-$version-linux-$arch.tar.gz"
else
wget -P "$defp" https://dl.nwjs.io/$version/nwjs-$version-linux-$arch.tar.gz


tar -xf "$defp/nwjs-$version-linux-$arch.tar.gz" -C "$defp/nwjs"
rm "$defp/nwjs-$version-linux-$arch.tar.gz"
fi
fi
echo Finished
fi
