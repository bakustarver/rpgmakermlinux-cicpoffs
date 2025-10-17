#!/bin/bash

version='1.1.6'

default_dir="$HOME/desktopapps"
mainfdtxt="$HOME/.config/defrpgmakerlinuxpath.txt"

if [[ -r "$mainfdtxt" ]] && read -r line < "$mainfdtxt" && [[ -n "$line" ]]; then
  mainfd="${line%/}"
else
  mainfd="$default_dir"
fi
export mainfd
export nwjsfm="$mainfd/nwjs/nwjs"
export LD_LIBRARY_PATH="$mainfd/nwjs/nwjs/packagefiles/:$LD_LIBRARY_PATH"



if command -v yad > /dev/null 2>&1; then
yadp="$(command -v yad)"
else
yadp="$nwjsfm/packagefiles/yad"
fi
export yadp
if command -v strings > /dev/null 2>&1; then
stringsbin="$(command -v strings)"
else
stringsbin="$nwjsfm/packagefiles/strings"
fi
tyranounpacker="$nwjsfm/packagefiles/tyranodataextract"
electronfd="$mainfd/electron-tyrano"
mkxpzp="$mainfd/mkxp-z"
evbunpack="$nwjsfm/packagefiles/evbunpack"
ndmodulesfd="$nwjsfm/packagefiles/tyranobuilder/node_modules"
configfile="$HOME/.config/rpgmenu-config.json"

defp="$nwjsfm/nwjs"
export defpn="$nwjsfm"
export DWNWJSNODEBUG=true

nwjslist=$(ls -p "$defp" | grep -v "www" | grep /)

nwjsonlylist=$(echo "$nwjslist" | grep -v "sdk")
nwjssdkonlylist=$(echo "$nwjslist" | grep "sdk")

if echo "$nwjslist" | grep -q "\-sdk"; then
# sdkinstalled=true
latestinstallednwjsfd=$(echo "$nwjssdkonlylist" | sort -V | uniq | tail -n 1)
# allversionsnwjs=$(echo "$nwjslist" | sed -e 's@-sdk-@@g' -e 's@nwjs-@@g' -e 's@-linux-.*@@g' | sort -V | uniq)
else
latestinstallednwjsfd=$(echo "$nwjslist" | tail -n 1)
fi
allversionsnwjs=$(echo "$nwjslist" | sed -e 's@sdk-@@g' -e 's@nwjs-@@g' -e 's@-linux-.*@@g' | sort -V | uniq | tac)
#
# echo "$latestinstallednwjsfd"
# exit
githubscriptwget=$(timeout 7s wget -qO- "https://raw.githubusercontent.com/bakustarver/rpgmakermlinux-cicpoffs/main/installgithub.sh" )

# latestinstallednwjsfd=$(ls -p "$defp" | grep / | sort -V | tail -n 1 )


if [ -n "$githubscriptwget" ]; then
githubversion=$(echo "$githubscriptwget" | sed -n 's/version=//p')
if [ "$version" != "$githubversion" ]; then
if { echo "$version"; echo "$githubversion"; } | sort --version-sort -C; then
echo "A new rpgmaker-linux update has been found, to get the latest version use
$ rpgmaker-linux --fullupdate


"
fi
fi
fi




arch=$(uname -m)
archcheckmessage=$(echo "$arch" | sed -e 's@x86_64@, x86-64, version@g' -e 's@aarch64@, ARM aarch64,@g' -e 's@i686@, Intel 80386,@g' -e 's@i386@, Intel 80386,@g' -e 's@armv7l@, ARM,@g' -e 's@armhf@, ARM,@g')
if [[ "$arch" == *"arm"* ]]; then
armsys=true
fi

checkthebinaryarch() {
if ! [ -f "$1" ]; then
echo "Missing file $1"
# echo "Use
# $ rpgmaker-linux "
exit;
fi

if ! file "$1" | grep -q "$archcheckmessage" ; then
# Use $ wget -qO- installscript.sh | bash
file "$1"
echo "Wrong architecture!! Use
$ rpgmaker-linux --fullupdate
to get correct version"
exit 1;
fi
}

checkthebinariesarch() {
"$cicpoffs"
# - ask for download?
# - set custom path
"$nwjstestpath/nw"
# cicpoffspath

}


makedesktopfile() {
# $mountpath
geticonpath=$(sed -n 's/.*"icon": "//p' "$nwjstestpath/package.json" | sed -e 's@"@@g')
if [ "$engine" = "mz" ] && [ -z "$PACKAGEJSONPATH" ]; then
geticonpath=$(echo "$geticonpath" | sed -e 's@www/@@g');
fi
ndirname="$npath"

ndrbasen=$(basename "$ndirname")
iconpath="$ndirname/$geticonpath"
if [ -z "$dsavepath" ]; then
dsavepath="$ndirname"
fi

if ! [ -f "$dsavepath/$ndrbasen.desktop" ]; then
echo "[Desktop Entry]
Name=$ndrbasen
Exec=env gamef=\"$ndirname\" $nwjsfm/packagefiles/nwjsstart-cicpoffs.sh
Type=Application
Categories=Game
StartupNotify=true
MimeType=application/x-ms-dos-executable;application/x-wine-extension-msp;
Icon=$iconpath
Terminal=true" > "$dsavepath/$ndrbasen.desktop"
chmod +x "$dsavepath/$ndrbasen.desktop"
fi
}

makelocalshortcut() {
dsavepath=""
makedesktopfile
}

makedesktopshortcut() {
dsavepath=$(xdg-user-dir DESKTOP)
makedesktopfile
}

makethemenushortcut() {
dsavepath="$HOME/.local/share/applications/"
makedesktopfile
}

pixi5install() {
echo "Installing pixi5"
newjsfd="$nwjsfm/packagefiles/rpgmaker-mv-pixi5/js"
curjs="$mountpath/js"
if grep "pixi.js - v5." "$curjs/libs/pixi.js"; then
echo "The pixi5 lib is already installed"
else
mv "$curjs" "$mountpath/js-backup"
cp -r "$newjsfd" "$mountpath"
cp -r "$mountpath/js-backup/plugins" "$curjs"
cat "$mountpath/js-backup/plugins.js" > "$curjs/plugins.js"
echo "pixi5 was installed"
fi
#pixi func
}


relocaterpgmaker() {
echo test
}

plugininstallfunc() {
# echo "Installing the text hooker plugin"
yourplugin="$1"
bnpl=$(basename "$1" | sed -e 's@.js@@g')
pluginslistfile="$mountpath/js/plugins.js"

if grep -q "$bnpl\",\"status\":true," "$pluginslistfile"; then
echo "The $bnpl plugin is already installed"
else
cp "$pluginslistfile" "$pluginslistfile.bk"
sed -e "s@^\[@[\n$pluginset@g" -i "$pluginslistfile"
cp "$yourplugin" "$mountpath/js/plugins/";

fi
}


texthookerpluginuninstall() {
echo "Uninstalling the text hooker plugin"
pluginsfile="$mountpath/js/plugins.js"
if grep -q 'Clipboard_llule","status":true,' "$pluginsfile"; then
sed -e 's@{"name":"Clipboard_llule".*@@g' -i "$pluginsfile"
else
echo "The text hooker plugin is not installed"
fi


}

fivehundredslotsplugininstall() {
pluginset='{"name":"CustomizeMaxSaveFile","status":true,"description":"Customize max save file number","parameters":{"SaveFileNumber":"500"}},'
plugininstallfunc "$nwjsfm/packagefiles/plugins/CustomizeMaxSaveFile.js"

}

texthookerplugininstall() {
pluginset='{"name":"Clipboard_llule","status":true,"description":"","parameters":{}},'
plugininstallfunc "$nwjsfm/packagefiles/plugins/Clipboard_llule.js"

}



sourcelinks() {

echo "Github page
https://github.com/bakustarver/rpgmakermlinux-cicpoffs

Patreon page
https://www.patreon.com/user/about?u=121421184

Buymeacoffe page
https://www.buymeacoffee.com/rpgmakerlinux"
}

incompletefeaturefunc() {
echo "$arg" in development, wait for it.
echo "https://github.com/bakustarver/rpgmakermlinux-cicpoffs"
}


fullupdatereinstall() {
echo "$githubscriptwget" | bash
}

unpackexe() {
gameexe="$1"
gameexefd="$1-extracted"
originalexe=$(echo "$1" | sed -e 's@\.exe@@g' -e 's@$@_original.exe-extracted@g')
# "$evbunpack" "$gameexe" "$gameexefd"
evbunpack "$gameexe" "$gameexefd"
# find "$gameexefd" -type f \( -name "*.exe" \) -delete
cp -r "$gameexefd"/* "$npath"
mkdir "$originalexe"
}

tyranoextractv4exe() {
if [ -n "$exenpath" ]; then
# kdialog --msgbox "hhhcc"
"$tyranounpacker" exe "$exenpath" "$npath"
else
exenpath=$(ls -p "$npath" | grep -v "/$" | grep "\.exe$")
"$tyranounpacker" exe "$exenpath" "$npath"
fi
}

tyranolndatafd() {
rm "$mainfd/nwjs/nwjs/packagefiles/tyranobuilder/tyranoeng/data"
if [ -f "$npath/data/others/translate/main.js" ]; then
cat "$mainfd/nwjs/nwjs/packagefiles/tyranobuilder/pathches/tf/main.js" > "$npath/data/others/translate/main.js"
fi
ln -fs "$npath/data" "$mainfd/nwjs/nwjs/packagefiles/tyranobuilder/tyranoeng"
}


mkxpzdownload() {

if [ "$arch" = "i686" ]; then
echo For this release, i686 not supported
exit;
fi
if [ -n "$REINSTALLMKXPZ" ]; then
echo Reinstalling mkxpz
rm -rf "$mkxpzp"
fi

link="https://github.com/bakustarver/rpgmakermlinux-cicpoffs/releases/download/libraries/mkxp-z.$arch.zip"
wget -O /tmp/mkxp-z.zip "$link"
unzip -d "$mkxpzp" /tmp/mkxp-z.zip
sed -e "s@\"RGSS@\"$mkxpzp/RGSS@g" -e "s@\"Kawariki-patches@\"$mkxpzp/Kawariki-patches@g" -i "$mkxpzp/mkxp.json"
rm /tmp/mkxp-z.zip
}

mkxpzdialog() {
$yadp --image="dialog-question" \
  --title "Rpg Maker VX Ace / VX/ XP Launcher: $line" \
  --text "Mkxp-z module is not installed\nWould you like to download it?\n+390 mb" \
  --button="Yes:0" \
  --button="No:1" \
retmkxpz=$?

if [[ $retmkxpz -eq 1 ]]; then
exit;
elif [[ $retmkxpz -eq 0 ]]; then
mkxpzdownload;
fi

}



electron-tyrano-downloader() {
yarch=$(echo "$arch" | sed -e 's@x86_64@x64@g' -e 's@i686@ia32@g' -e 's@aarch64@arm64@g')
link="https://github.com/electron/electron/releases/download/v9.4.4/electron-v9.4.4-linux-$yarch.zip"
wget -O /tmp/electron-tyrano.zip "$link"
unzip -d "$electronfd" /tmp/electron-tyrano.zip
rm /tmp/electron-tyrano.zip
}

tyranocheckelectron() {
$yadp --image="dialog-question" \
  --title "Tyranobuilder Launcher: $line" \
  --text "Found electron game $line!\nHow would you like to open it?" \
  --button="Electron (Recomended):0" \
  --button="NWJS:1" \
  --button="Exit:2"
rettyranoelectron=$?
if [ -n "$asarpath" ]; then
"$tyranounpacker" asarapp "$asarpath" "$npath/resources/app"
fi


if [[ $rettyranoelectron -eq 0 ]]; then


if ! [ -f "$electronfd/electron" ]; then
electron-tyrano-downloader
fi

rm "$electronfd/resources/app"
sed '/$.userenv = function/,/};/c\
    $.userenv = function () {\
        return "pc";\
    };' -i "$npath/resources/app/tyrano/libs.js"
ln -fs "$npath/resources/app" "$electronfd/resources/"
usetyranoelectron=true
elif [[ $rettyranoelectron -eq 1 ]]; then
rm "$mainfd/nwjs/nwjs/packagefiles/tyranobuilder/tyranoeng/data"
ln -fs "$npath/resources/app/data" "$mainfd/nwjs/nwjs/packagefiles/tyranobuilder/tyranoeng"
usetyranoelectron=""
elif [[ $rettyranoelectron -eq 2 ]]; then
exit;
fi
}

mkxpzdialogoptions() {
$yadp --image="dialog-question" \
  --title "Mkxp-z Options: $line" \
  --text "Found the rppmaker game $line!\nHow would you like to open it?" \
  --button="Linux mkxp-z:0" \
  --button="Windows mkxp-z (Requires Wine):1" \
  --button="Exit:2"
rettyranoelectron=$?


if [[ $rettyranoelectron -eq 0 ]]; then
mkxpopt=linux

elif [[ $rettyranoelectron -eq 1 ]]; then
mkxpopt=wine
elif [[ $rettyranoelectron -eq 2 ]]; then
exit;
fi
}

godotdownloadsdk() {
# if ! timeout 15s wget -q --spider "https://downloads.tuxfamily.org/godotengine/"; then
# echo "Cannot connect to the godot server"
# fi
if [ -z "$execpath" ]; then
exen=$(ls -p "$npath" | grep -v "/$" | grep "\.exe$" )
fi


while IFS= read -r line; do
godotold=""
exenn=$(echo "$line" | sed "s@.exe@@g" )
strgodotexe=$("$stringsbin" "$npath/$line")
versiongodot=$(echo "$strgodotexe" | grep -m 1 'Godot Engine v' | sed -e 's@.* v@@g' -e 's@.official@@g' )
if [ -z "$versiongodot" ]; then
# echo zzz
versiongodot=$(echo "$strgodotexe" | grep -B 1 "User-Agent:" | grep "[0-9]\.[0-9]\." | grep -v "User-Agent:" | sed -e 's@.official@@g' )
# echo "exe $exenpath"
godotold=true
fi
if [ -z "$versiongodot" ]; then
versiongodot=$(echo "$strgodotexe" | grep '[0-9]\.[0-9]\.[0-9]\.stable\.' )
fi
# echo "$exen"
# echo "cc $versiongodot"

if [ -n "$versiongodot" ]; then
n1godot=$(echo "$versiongodot" | sed -e 's@\.[a-Z].*@@g')
n2godot=$(echo "$versiongodot" | sed -e 's@.*\.@@g')
garch=$(echo "$arch" | sed -e 's@86_64@86_64@g' -e 's@i686@x86_32@g' -e 's@aarch64@arm64@g' -e 's@armv7l@arm32@g')
versinid="_linux.$garch.zip"
if [ "$n2godot" =  "custom_build" ]; then
$yadp --image="dialog-question" \
  --title "Godot SDK Downloader: $line" \
  --text "It seems that this version of the Godot game has the own custom compilation\nand there may be problems with it!\nWould you like to download the standard SDK for this game?" \
  --button="Yes:0" \
  --button="Exit:1"
retgodotcustom=$?
if [[ $retgodotcustom -eq 0 ]]; then
customsdk=true;
n2godot="stable"
elif [[ $retgodotcustom -eq 1 ]]; then
exit;
fi
fi
echo $versiongodot
# https://downloads.tuxfamily.org/godotengine/3.5.2/
if [ "$godotold" = "true"  ]; then
# echo "ccc $garch"
garch=$(echo "$garch" | sed -e 's@x86_64@64@g' -e 's@x86_32@32@g')
if [ "$garch" = "64" ] && [ "$garch" = "32" ]; then
echo "The Godot version don't have any arm versin";
exit;
fi

# https://github.com/godotengine/godot/releases/download/4.4.1-stable/Godot_v4.4.1-stable_linux.x86_64.zip
# https://github.com/godotengine/godot/releases/download/4.1-stable/Godot_v4.1-stable_linux.x86_64.zip
versinid="_x11.$garch.zip"
# godotsdklink="https://downloads.tuxfamily.org/godotengine/$n1godot/Godot_v$n1godot-$n2godot$versinid"
if [ "$n2godot" = "mono" ]; then
stablepr="stable_"
versinid="_x11_$garch.zip"
fi
if [ "$n2godot" = "beta" ]; then
$n2godot="stable"
fi
godotsdklink="https://github.com/godotengine/godot/releases/download/$n1godot-stable/Godot_v$n1godot-$stablepr$n2godot$versinid"
# else
# # if [ "$n2godot" = "stable" ]; then
# # godotsdklink="https://downloads.tuxfamily.org/godotengine/$n1godot/Godot_v$n1godot-$n2godot$versinid"
#
# # godotsdklink="https://github.com/godotengine/godot/releases/download/$n1godot-stable/Godot_v$n1godot-$stablepr$n2godot$versinid"
# # echo "https://downloads.tuxfamily.org/godotengine/$n1godot/Godot_v$n1godot-$n2godot$versinid"
# # echo "https://downloads.tuxfamily.org/godotengine/$n1godot/$n2godot/Godot_v$n1godot-$n2godot$versinid"
#
# else
# # godotsdklink="https://downloads.tuxfamily.org/godotengine/$n1godot/$n2godot/Godot_v$n1godot-$n2godot$versinid"
# fi
fi
# echo "$n1godot-$stablepr$n2godot$versinid"

# echo "$godotsdklink"
if wget -q --spider "$godotsdklink"; then
dglink="$godotdownloadsdk"
fi

archivngodot=$(basename "$godotsdklink")
binname=$(echo "$archivngodot" | sed -e 's@.zip@@g')
if ! [ -f "$npath/$exenn.$garch" ]; then
if wget -q --spider "$godotsdklink"; then
echo "$godotsdklink"
wget -c "$godotsdklink" -P "$npath"
else
# echo "$godotsdklink"
echo "Can't connect to the godot server"
exit;
fi

unzip -d "$npath" "$npath/$archivngodot";
mv "$npath/$binname" "$npath/$exenn.$garch";
rm "$npath/$archivngodot";
fi
"$npath/$exenn.$garch"
exit;
else
echo "Can't find the Godot version in exe"
fi
done <<< "$exen"
}

tyranoelectron() {
if [ -n "$asarpath" ]; then
"$tyranounpacker" asarapp "$asarpath" "$npath/resources/app"
fi
rm "$electronfd/resources/app"
sed '/$.userenv = function/,/};/c\
    $.userenv = function () {\
        return "pc";\
    };' -i "$npath/resources/app/tyrano/libs.js"
ln -fs "$npath/resources/app" "$electronfd/resources/"
usetyranoelectron=true
}


searchforpackedexe() {
# echo fffvvvv
local gfexe=$(ls -p "$1" | grep -v "/$" | grep "\.exe$" | head -n 6)
# echo "$gfexe"
npath="$1"
if [ -n "$gfexe" ]; then
while IFS= read -r line; do
# check=$()
# echo "$npath/$line"
#check 1 kb of the binary
allstrings=$(head -c 5120 "$npath/$line" | "$stringsbin")
if echo "$allstrings" | grep -q "8MZu" && echo "$allstrings" | grep -q "pck"; then
# echo vvv
# "$pckextract" "$npath/$line"
linenoexe=$(echo "$line.pck" | sed "s@\.exe@@g")
# mv "$npath/$line.pck" "$npath/$linenoexe"
if ! [ -f "$linenoexe" ]; then
cp "$line" "$linenoexe"
fi
fi
# echo "jjj"
# !CreatePipe(&pipe[0]
if ! [ -d "$npath/$line-extracted" ]; then
# echo hmmm
if echo "$allstrings" | grep -m 1 -q "\.enigma"; then
$yadp --image="dialog-question" \
  --title "RPG Maker linux: $line" \
  --text "Detected game files in $line!\nWould you like to unpack it?" \
  --button="Yes:0" \
  --button="No:1"
ret=$?
# ret=1;
# fi
name=$(echo "$line")


if [[ $ret -eq 1 ]]; then
mkdir "$npath/$line-extracted";
elif [[ $ret -eq 0 ]]; then
unpackexe "$npath/$line"
fi
fi
# echo "$name"
# echo "$check"
fi
done <<< "$gfexe"
fi
}


updatenwjs() {
if [ -f "$nwjsfm/packagefiles/usesdk.txt" ]; then
export latestlocal=$(echo "$nwjssdkonlylist" | tail -n 1 | sed -e 's@nwjs-sdk-@@g' -e 's@-linux.*@@g' )
# echo "gggsagsga"
"$nwjsfm/dwnwjs.sh"
else
export latestlocal=$(echo "$latestinstallednwjsfd" | sed -e 's@nwjs-@@g' -e 's@-linux.*@@g')
"$nwjsfm/dwnwjs.sh"
fi
nwjslist=$(ls -p "$defp" | grep -v "www" | grep /)

}

nwjsversionfunc() {
export skipdownloadifexist=true
. "$nwjsfm/dwnwjs.sh" "$1"
nwjsversion=$1
# nwjsversion=(echo "$nwjsversion"
}

checkifexist() {
if ! [ -f "$1" ]; then
echo "Can't find the file $1"
exit
fi
}

mkxpfunc() {
if [ -z "$mkxpfound" ]; then

if ! [ -f $mkxpzp/mkxp-z.$arch ]; then
mkxpzdialog
fi
npath=$(echo "$npath" | sed -e 's@\&@\\&@g')
sed -e "s@.*.gameFolder.*@    \"gameFolder\": \"$npath\",@g" -i "$mkxpzp/mkxp.json"
if [ "$mkxpopt" = "wine" ]; then
wine "$mkxpzp/mkxp-z.exe"
else
"$mkxpzp/mkxp-z.$arch"
fi
mkxpfound=true

fi
}





pchange() {
if echo "$1" | grep ".exe"; then
dirname "$1" | sed -e "s@^'@@g"
else
echo "$1"
fi
# echo "Use "$arg' "/path/rpggame/"'
# exit 1
# fi
}

electronch2() {
if [ -f "$electronfd/electron" ]; then
tyranoelectron
tyranoeng=electron
else
tyranocheckelectron
fi
}

tyranofuncv4() {
mountpath="$npath"
# gamepath=true
# found=true
engine=tyrano
tyranover=v4
tyranoeng=nwjs

if [ -d "$npath/data" ] && [ -e "$npath/data/system/Config.tjs" ]; then
tyranolndatafd
else
tyranoextractv4exe
tyranolndatafd
fi
}


tyranofuncv5() {
engine=tyrano
tyranover=v5
if [ -d "$npath/resources/app/data" ] && [ -f "$npath/resources/app/index.html" ] && [ -f "$npath/resources/app/main.js" ] && [ -d "$npath/resources/app/tyrano" ]; then
electronch2
elif [ -f "$npath/resources/app.asar" ]; then
asarpath="$npath/resources/app.asar"
electronch2
fi
}




checkgamefilesfd() {
npath=$(echo "$1" | sed -e 's@rpgmakermp:///@@g')
# echo "$npath"
if echo "$npath" | grep -q ".exe"; then
exenpath="$npath"
npath=$(dirname "$npath" | sed -e "s@^'@@g");
else
npath="$npath"
fi
# kdialog --msgbox "$npath"
# zenity --title "$gamef" --warning --text="$npath"
searchforpackedexe "$npath"
if [ -d "$npath/www" ] && [ -e "$npath/package.json" ] && [ -e "$npath/www/js/plugins.js" ]; then
mountpath="$npath/www"
found=true
gamepath=true
engine=mv
elif [ -d "$npath/data" ] && [ -e "$npath/package.json" ] && [ -e "$npath/js/plugins.js" ]; then
mountpath="$npath"
gamepath=true
found=true
engine=mz
elif [ -e "$npath/Game.ini" ] && [ -e "$npath/Game.exe" ]; then
# mkxpfunc
engine=mkxpz
elif [ -e "$npath/package.nw" ]; then
# mkxpfunc
engine=construct-nwjs
elif [ -e "$npath/nscript.dat" ]; then
# mkxpfunc
engine=nscripter
elif [ -e "$npath/ffmpegsumo.dll" ] && [ -e "$npath/nw.pak" ] && [ -e "$npath/d3dcompiler_47.dll" ] && [ -e "$npath/nw.pak" ]; then
tyranofuncv4
elif [ -d "$npath/resources" ] && [ -d "$npath/locales" ] && [ -e "$npath/chrome_100_percent.pak" ] && [ -e "$npath/natives_blob.bin" ] && [ -e "$npath/chrome_200_percent.pak" ]; then
tyranofuncv5

else
# kdialog --msgbox "xxzxz"
checkpck=$(ls "$npath" | grep "\.pck")
if [ -n "$checkpck" ]; then
godotdownloadsdk
else
echo "Can't find any game in $npath"
exit 1
fi

fi
}



checkgamepath() {
# path="$1"
echo "$1"

if ! [ -n "$CPATH" ]; then
path=$(pchange "$1")
else
path="$CPATH"
fi
# kdialog --msbox "$path"
checkgamefilesfd "$path"
}
searchforpackedexe "$PWD"

if [ -z "$gamepath" ]; then
if [ -d ./www ] && [ -f ./package.json ]; then
mountpath="$PWD/www"
found=true
engine=mv
npath="$PWD"
elif [ -d ./js ] && [ -f ./package.json ] &&  [ -d ./data ]; then
mountpath="$PWD"
found=true
engine=mz
npath="$PWD"
elif [ -e "./ffmpegsumo.dll" ] && [ -e "./nw.pak" ] && [ -e "./d3dcompiler_47.dll" ] && [ -e "./nw.pak" ]; then
npath="$PWD"
tyranofuncv4
elif [ -d "./resources" ] && [ -d "./locales" ] && [ -e "./chrome_100_percent.pak" ] && [ -e "./natives_blob.bin" ] && [ -e "./chrome_200_percent.pak" ]; then
npath="$PWD"
tyranofuncv5
elif [ -e "./Game.ini" ] && [ -e "./Game.exe" ]; then
# mkxpfunc
engine=mkxpz
elif [ -e "./package.nw" ]; then
# mkxpfunc
engine=construct-nwjs
elif [ -e "./nscript.dat" ]; then
# mkxpfunc
engine=nscripter
else
npath="$PWD"
checkpck=$(ls "$npath" | grep "\.pck")
if [ -n "$checkpck" ]; then
godotdownloadsdk
else
# echo "Can't find game in $npath"
notfound=true
# exit 1
fi
fi
fi
# fi
#
if [ -z "$found" ]; then
if [ -n "$gamef" ]; then
# kdialog --msgbox "$gamef"
checkgamefilesfd "$gamef"
fi
fi



checknwjspath() {
path="$1"
if [ -d "$path/lib" ] && [ -e "$path/nw" ]; then
NWJSPATH="$path"
else
echo "Can't find the NWJS"
exit 1
fi
}

checkcicpoffspath() {
path="$1"
if [ -e "$path" ]; then
cicpoffs="$path"
cicpoffspath="true"
else
echo "Can't find the cicpoff binary"
exit 1
fi
}

packagejsonfunc() {
if [ -n "$PACKAGEJSONPATH" ]; then
packagejson="$PACKAGEJSONPATH"
else
packagejson="$mainfd/nwjs/nwjs/packagefiles/package.json"
fi
packagejsoninfo=$(cat "$packagejson")

if [ -n "$PACKAGEJSONPATH" ]; then
newpackagejson=$(echo "$packagejsoninfo" | sed -e 's@"name": "",@"name": "RPG Maker MV/MZ (cicpoffs mount)",@g' -e 's@"main": ".*@"main": "www/index.html",@' -e 's@"title": "",@"title": "RPG Maker MV/MZ (cicpoffs mount)",@g')
else
newpackagejson=$(echo "$packagejsoninfo")
fi

# echo "$packagejson"
# ln -s "$packagejson" "$nwjstestpath"
if [ -h "$nwjstestpath/package.json" ]; then
rm "$nwjstestpath/package.json"
fi
echo "$newpackagejson" | sed -e "s@packagefiles@$nwjsfm/packagefiles@g" > "$nwjstestpath/package.json"
}

enhancedprotection() {
if [ "$1" = "false" ]; then
echo '{
  "lastScript": null,
  "uiVisibility": {
    "scriptSelect": true,
    "executeButton": true,
    "disableexec": false,
    "disablenet": false,
    "resultDisplay": true
  }
}' > "$configfile"
echo "Enhanced protection disabled."
else
if [ -e "$configfile" ]; then
sed -e 's@"disablenet":.*@"disablenet": true,@g' -e 's@"disableexec":.*@"disableexec": true,@g'  -i "$configfile"
else
echo '{
  "lastScript": null,
  "uiVisibility": {
    "scriptSelect": true,
    "executeButton": true,
    "disableexec": true,
    "disablenet": true,
    "resultDisplay": true
  }
}' > "$configfile"
fi
echo "Enhanced protection enabled successfully."
fi
# echo "Failed to enable enhanced protection. Please check your configuration."
}

editconfigfunc () {
  local option="$1"
  local state="$2"
  if [[ ! -f "$configfile" ]]; then
  echo "Error: Config file '$configfile' not found." >&2
  exit 1
  fi

  # Validate option argument
  if [[ "$option" != "disableexec" && "$option" != "disablenet" ]]; then
    echo -e "Use\nrpgmaker-linux editconfig disableexec <true|false>\nrpgmaker-linux editconfig disablenet <true|false>"
    return 2
  fi

  # Validate state
  if [[ "$state" != "true" && "$state" != "false" ]]; then
    echo "Error: Invalid state '${state}'. Valid states are 'true' or 'false'." >&2
    return 3
  fi

  # Apply the setting (placeholder for real logic)
  sed "s@.$option.:.*@\"$option\": $state,@g"  -i "$configfile"
  if [[ "$state" == "true" ]]; then
    echo "Operation successful: '${option}' has been enabled."
  else
    echo "Operation successful: '${option}' has been disabled."
  fi

  return 0


}
while [ $# -ne 0 ]
do
    arg="$1"
    arg2="$2"
    arg3="$3"
    case "$arg" in
        --help)
            help=true
            info=true
            ;;
        --version)
            showversion=true
            info=true
            ;;
        --checkreleaseupdates)
            info=true
            incompletefeaturefunc
            ;;
        --gui)
            GUIMENU=true
            ;;
        --relocate)
            relocaterpgmaker
            ;;
        --usestandart)
#             export SDKNWJS=true
            if [ -e "$nwjsfm/packagefiles/usesdk.txt" ]; then
            rm "$nwjsfm/packagefiles/usesdk.txt"
            fi
            ;;
        --pixi5install)
            INSTALLPIXI5=true
            ;;
        --installtexthookerplugin)
            INSTALLTHPL=true
            ;;
        --install500slotsplugin)
            FIVEHUNDREDSAVESLOTSPLUGIN=true
            ;;
        --uninstalltexthookerplugin)
            INSTALLTHPL=false
            ;;
        --usesdk)
#             export SDKNWJS=true
            touch "$nwjsfm/packagefiles/usesdk.txt"
            if [ -z "$nwjssdkonlylist" ]; then
            updatenwjs
            fi
            ;;
        --checkbetaupdates)
            info=true
            incompletefeaturefunc
            ;;
        --chooselatestnwjs)
            latestnwjs=true
            ;;
        --nwjsversion)
            nwjsversionfunc "$2"
            ;;
        --deleteoldnwjs)
            clearoldnwjs=true
            ;;
        --updatenwjs)
            updatenwjs
            ;;
        --fullupdate)
            fullupdatereinstall
            ;;
        --updatescripts)
            updatescriptsgithub=true
            ;;
        --makeshortcut)
            case "$arg2" in
                local)
                    MAKELOCALSHORTCUT=true
                    ;;
                desktop)
                    MAKEDESKTOPSHORTCUT=true
                    ;;
                menu)
                    ADDTOTHEMENU=true
                    ;;
                all)
                    MAKELOCALSHORTCUT=true
                    MAKEDESKTOPSHORTCUT=true
                    ADDTOTHEMENU=true
                    ;;

                *)
                    echo -e "Use --makeshortcut local or desktop or menu all"
                    info=true
                    ;;
            esac
            ;;
        --enhancedprotection)
            case "$arg2" in
                true)
                    enhancedprotection
                    ;;
                false)
                    enhancedprotection false
                    ;;

                *)
                    echo -e "Use --enhancedprotection <true|false>"
                    ;;
            esac

            info=true
            ;;
        editconfig)
            info=true
            editconfigfunc "$arg2" "$arg3"
            ;;
        --mounttype)
            case "$arg2" in
                cicpoffs)
                    CICPOFFSMOUNT=true
                    ;;
                jskawariki)
                    JSCASEINSENSITIVEPATCH=true
                    ;;
                link)
                    export DISABLECASEINSENSITIVEPATCH=true
                    ;;
                none)
                    NOMOUNT=true
                    ;;
                *)
                      echo -e 'Options:
  --mount-type <mode>   Select mount mode. Valid modes are:
                          cicpoffs        Mount using cicpoffs
                          jskawariki      Use jskawariki patch
                          link            Create only a symbolic link
                          none            Do nothing'
                    info=true
                    ;;
            esac
            ;;
        --gamepath)
            echo "$@ $2"
            checkgamepath "$2"
            ;;
        --useoriginalgamepackagejson)
            if [ -f "$path/package.json" ]; then
            PACKAGEJSONPATH="$path/package.json"
            echo "$path"
            elif [ -f "$mountpath/package.json" ]; then
            PACKAGEJSONPATH="$mountpath/package.json"
            elif [ -f "$PWD/package.json" ]; then
            PACKAGEJSONPATH="$PWD/package.json"
            else
            echo "Can't detect the original package.json"
            fi
            useoriginalgamepackagejson=true
            ;;
        --custompackagejsonpath)
            checkifexist "$2"
            PACKAGEJSONPATH="$2"
            custompackagejsonpath=true
            ;;
        --nwjspath)
            checknwjspath $2
            ;;
        --cicpoffspath)
            checkcicpoffspath "$2"
            ;;
        --printrpgmakerlibversions)
            printrpgmakerlibversions=true
            info=true
            ;;
        --exportthegame)
            EXPORTTHEGAME=true
            ;;
        --bugreport)
            BUGREPORT=true
            ;;
        --forceaarch)
            incompletefeaturefunc
            case "$arg2" in
                x86_64)
                    forceaarch="x86_64"
                    ;;
                i386)
                    forceaarch="i386"
                    ;;
                ia32)
                    forceaarch="i386"
                    ;;
                aarch64)
                    forceaarch="arm64"
                    ;;
                arm64)
                    forceaarch="arm64"
                    ;;
                armhf)
                    forceaarch="armhf"
                    ;;
                *)
#                     nothing="true"
                    echo -e "
Available architectures are
x86_64
i386
arm64
armhf"
                    info=true
                    ;;

            esac
            ;;
        --jpnlocale)
            export LANG="ja_JP.utf8"
            ;;
        --reinstallmkxpz)
            REINSTALLMKXPZ=true mkxpzdownload
            ;;
        --steamskipgui)
            case "$arg2" in
                true)
                    echo " " > "$HOME/.config/steamskipgui.txt"
                    echo "Gui is disabled now"
                    info=true
                    ;;
                false)
                    rm "$HOME/.config/steamskipgui.txt"
                    echo "Gui is enabled now"
                    info=true
                    ;;
                *)
                    echo -e "Use --steamskipgui true\n--steamskipgui false"
                    info=true
                    ;;
            esac
            ;;
        --sourcelinks)
            sourcelinks
            info=true
            ;;
        *)
            nothing="true"
            ;;
    esac
    shift
done

if [ -z "$nwjslist" ]; then
echo "the nwjs is not installed, please use $ rpgmaker-linux --updatenwjs"
exit;
fi
# --chooselatestnwjs --choosenwjsversion --nwjspath
#latestnwjs=true $nwjsversion #NWJSPATH
if [ "$latestnwjs" = "true" ] && [ -n "$nwjsversion" ] || [ "$latestnwjs" = "true" ] && [ -n "$NWJSPATH" ] || [ -n "$nwjsversion" ]  && [ -n "$NWJSPATH" ]; then
echo "You can't use those arguments together --chooselatestnwjs --choosenwjsversion --nwjspath"
exit 1;
fi

if [ "$useoriginalgamepackagejson" = "true" ] && [ "$custompackagejsonpath" = "true" ] ; then
echo "You can't use those arguments together --useoriginalgamepackagejson --custompackagejsonpath"
exit 1;
fi

if [ "$showversion" = true ]; then
echo -e "$version"
fi



if [ "$help" = true ]; then
echo -e "RPGMaker MV/MZ for Linux [cicpoffs mount] v$version


Usage: rpgmaker-linux [OPTIONS]

Options:
  --help                          Show this help message.
  --version                       Show version of the program.
  --updatenwjs                    Update the NW.js to the latest version.
  --chooselatestnwjs              Choose the latest version of NW.js available on your PC.
  --nwjsversion <version>         Choose the version of NW.js you want to use.
  --deleteoldnwjs                 Delete old NW.js versions.
  --gamepath <path>               Specify the path to the RPG Maker game.
  --useoriginalgamepackagejson    Use the original game package.json file.
  --custompackagejsonpath <path>  Specify a custom path for the package.json file.
  --nwjspath <path>               Specify the custom path of the NW.js directory.
  --cicpoffspath <path>           Specify the cicpoffs binary path.
  --printrpgmakerlibversions      Show versions of RPG Maker MV/MZ game libraries.
  --forceaarch <architecture>     Force the use of specified architecture (e.g., x86_64, i386, aarch64) (incomplete feature).
  --checkbetaupdates              Check for beta updates (incomplete feature).
  --updatescripts                 Quickly update only the scripts in this tool from the github (Warning: May be missing files if you updating)
  --fullupdate                    Perform a full update of the rpgmaker-linux.
  --sourcelinks                   Print the list of links to the project's source code, documentation, and donation options in the output.
  --usesdk                        Use the NW.js SDK version.
  --pixi5install                  Install the Pixi 5 library.
  --install500slotsplugin         Install the 500 slots plugin.
  --installtexthookerplugin       Install the text hooker plugin.
  --uninstalltexthookerplugin     Uninstall the text hooker plugin.
  --reinstallmkxpz                Reinstall the mkxpz module.
  --steamskipgui <true|false>     Disable gui in steam.
  --makeshortcut <type>           Create a shortcut for the game (type: local, desktop, menu, all).
  --enhancedprotection <true|false>
        Toggle enhanced protection mode. When enabled, the game runs in a hardened sandbox:
          • Network and child-process spawning are blocked.
          • Dynamic code evaluation is restricted.
  --mount-type <mode>
        Select how the game folder is exposed to NW.js. Modes:
          cicpoffs       Mount with cicpoffs (case-insensitive file access).
          jskawariki     Use the jskawariki patch for case-insensitive handling.
          link           Don’t mount—just symlink the game folder.
          none           Disable mounting entirely;
  editconfig <option> <true|false>
        Edit rpgmaker-linux’s config file on the fly. Valid options are:
          disableexec    Disable in-game script execution for extra safety.
          disablenet     Disable all network access for the game.
  --bugreport                     Sends an anonymous report to developer about game data, system information, engine for fixing bugs and errors.
                                  You can describe in detail the issue or enhancement you would like to see.
  --exportthegame                 This option allows users to export their RPG Maker game into a distributable format. When this argument is used, the program will package the game
                                  files, including assets, scripts, and configurations, into a single folder or archive that can be easily shared or deployed.
                                  You can easily send the exported game to your friends who are using Linux, allowing them to enjoy the game without any additional setup.
  --gui                           Launch the GUI for easier management.

Examples:
  Run the RPG Maker game:
    rpgmaker-linux --gamepath /path/rpg-maker-game/

  Show version of the program:
    rpgmaker-linux --version

  Update the NW.js to the latest version:
    rpgmaker-linux --updatenwjs

  Show versions of RPG Maker game libraries:
    rpgmaker-linux --gamepath /path/rpg-maker-game/ --printrpgmakerlibversions

  Choose the version of NW.js you want to use:
    rpgmaker-linux --nwjsversion 0.40.0 --gamepath /path/rpg-maker-game/

  Show donation links:
    rpgmaker-linux --sourcelinks"
fi

updatescript() {
link="$1"
path="$2"
basenfile=$(basename "$2")
newupdate=$(wget -qO- "$1")
if [ -n "$newupdate" ]; then
echo "$newupdate" > "$path" ;
chmod +x "$path"
else
echo "Can't update" $basenfile
fi
}

if [ "$updatescriptsgithub" = "true" ]; then

updatescript "https://raw.githubusercontent.com/bakustarver/rpgmakermlinux-cicpoffs/main/nwjs/packagefiles/rpgmaker-linux-steam-wrapper/rpgmaker-linux-cicpoffs-wrapper.sh" "$HOME/.steam/steam/compatibilitytools.d/rpgmaker-linux-steam-wrapper/rpgmaker-linux-cicpoffs-wrapper.sh"
updatescript "https://raw.githubusercontent.com/bakustarver/rpgmakermlinux-cicpoffs/main/nwjs/dwnwjs.sh" "$mainfd/nwjs/nwjs/dwnwjs.sh"
updatescript "https://raw.githubusercontent.com/bakustarver/rpgmakermlinux-cicpoffs/main/nwjs/packagefiles/nwjsstart-cicpoffs.sh" "$mainfd/nwjs/nwjs/packagefiles/nwjsstart-cicpoffs.sh"

fi


exclude_list=(
    "credits.html"
    "www"
    "icudtl.dat"
    "notification_helper.exe"
    "package.json"
    "d3dcompiler_47.dll"
    "libegl.dll"
    "nw_100_percent.pak"
    "resources.pak"
    "debug.log"
    "libglesv2.dll"
    "nw_200_percent.pak"
    "ffmpeg.dll"
    "locales"
    "nw.dll"
    "swiftshader"
    "game.exe"
    "game_en.exe"
    "node.dll"
    "nw_elf.dll"
    "v8_context_snapshot.bin"
    "patch-config.txt"
    "dazed"
    "ffmpegsumo.dll"
    "installscript.vdf"
    "snapshot_blob.bin"
    "nw.pak"
)

yaddata() {
updatenwjsvar=$(echo "$@" | awk '{print $1}')
pixiupdatevar=$(echo "$@" | awk '{print $2}')
localshortcutvar=$(echo "$@" | awk '{print $3}')
nwjsguivar=$(echo "$@" | awk '{print $4}')
fivehundredsaveslotspluginvar=$(echo "$@" | awk '{print $5}')
texthookerset=$(echo "$@" | awk '{print $6}')
desktopshortcut=$(echo "$@" | awk '{print $7}')
addtomenuvar=$(echo "$@" | awk '{print $8}')
sdkvar=$(echo "$@" | awk '{print $9}')

# kdialog --msgbox "$updatenwjsvar $pixiupdate $localshortcut $texthookerset dc $desktopshortcut $addtomenuvar $sdkvar $nwjsguivar hh $fivehundredsaveslotspluginvar"
}



guirpgmakermfn() {
if [ -d "$HOME/.config" ]; then
configgp="$HOME/.config/rpgmaker-guiconfig.txt"
else
configgp="$HOME/rpgmaker-guiconfig.txt"
fi
if [ -f "$configgp" ]; then
configgdata=$(cat "$configgp")
yaddata "$configgdata"
newversionlist=$(echo "$allversionsnwjs" | grep -v "^$nwjsguivar$" | sed "1s/^/$nwjsguivar\n/")
if [ -z "$newversionlist" ]; then
newversionlist="$allversionsnwjs"
fi
# kdialog --msgbox "$nwjsguivar\n--$newversionlist"
guim=$("$yadp" --title "RPG Maker MV/MZ Options" --text="Please choose your options:" --image="$mainfd/nwjs/nwjs/packagefiles/nwjs128.png" --columns=5 --field "Update NWJS":chk $updatenwjsvar --form --field "Pixi5 Update":chk "$pixiupdatevar" --field="Shorcut Options::LBL" false --field "Local Shortcut":chk "$localshortcutvar" --form --separator=" " --item-separator="\n" --field="Versions::"CBE "$newversionlist" --field "500 Save Slots Plugin":chk "$fivehundredsaveslotspluginvar" --field "Texthooker Plugin":chk "$texthookerset" --field=" :LBL" false --field "Desktop Shortcut":chk "$desktopshortcut" --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field "Show in the Menu":chk "$addtomenuvar" --field "Use SDK version":chk "$sdkvar" --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false)
else
guim=$("$yadp" --title "RPG Maker MV/MZ Options" --text="Please choose your options:" --image="$mainfd/nwjs/nwjs/packagefiles/nwjs128.png" --columns=5 --field "Update NWJS":chk true --form --field "Pixi5 Update":chk false --field="Shorcut Options::LBL" false --field "Local Shortcut":chk true --form --separator=" " --item-separator="\n" --field="Versions::"CBE "$allversionsnwjs" --field "500 Save Slots PSlugin":chk false --field "Texthooker Plugin":chk false --field=" :LBL" false --field "Desktop Shortcut":chk false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field "Show in the Menu":chk false --field "Use SDK version":chk false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false)
fi

if [ -n "$guim" ] ; then
echo "$guim" > "$configgp"
else
exit;
fi
yaddata "$guim"
# echo "$guim"



# exit;
if [ "$fivehundredsaveslotspluginvar" = "TRUE" ]; then
# export LANG="ja_JP.utf8"
export FIVEHUNDREDSAVESLOTSPLUGIN=true
fi


if [ "$sdkvar" = "TRUE" ]; then
# echo ccc
if ! [ -f "$nwjsfm/packagefiles/usesdk.txt" ]; then
touch "$nwjsfm/packagefiles/usesdk.txt"
fi
elif [ "$sdkvar" = "FALSE" ]; then
if [ -f "$nwjsfm/packagefiles/usesdk.txt" ]; then
rm "$nwjsfm/packagefiles/usesdk.txt"
fi
fi


if [ "$updatenwjsvar" = "TRUE" ]; then
export skipdownloadifexist=true
export checkversionnwjs=false
updatenwjs
fi

if [ "$texthookerset" = "TRUE" ]; then
INSTALLTHPL=true
elif [ "$texthookerset" = "FALSE" ]; then
INSTALLTHPL=false
fi

if [ "$pixiupdatevar" = "TRUE" ]; then
INSTALLPIXI5=true
fi


if [ "$localshortcutvar" = "TRUE" ]; then
MAKELOCALSHORTCUT=true
fi
if [ "$desktopshortcut" = "TRUE" ]; then
MAKEDESKTOPSHORTCUT=true
fi
if [ "$addtomenuvar" = "TRUE" ]; then
ADDTOTHEMENU=true
fi

if [ -n "$nwjsguivar" ]; then
nwjsversion="$nwjsguivar"
export skipdownloadifexist=true
export checkversionnwjs=false
. "$nwjsfm/dwnwjs.sh" "$nwjsguivar"
fi

}

if [ "$clearoldnwjs" = "true" ]; then
latestversion=$(echo "$allversionsnwjs" | head -n 1)
while IFS= read -r version; do

if ! [[ "${version}" =~ "${latestversion}" ]]; then
# if ! echo "$version" | grep -q "$latestversion"; then
   echo Deleting "$nwjsfm/nwjs/$version"
rm -rf "$nwjsfm/nwjs/$version"
# else
# echo fff
# echo "$version"
fi
done <<< "$nwjslist"

#         echo "cc $item - $base"

exit
fi


if [ "$GUIMENU" = "true" ]; then
if [ "$engine" = "tyrano" ]; then
echo tyrano;
# tyranover=v5
if [ "$tyranover" = "v5" ]; then
tyranocheckelectron
fi
elif  [ "$engine" = "mkxpz" ]; then
if [ -n "$SteamEnv" ] && [ -f "$HOME/.config/steamskipgui.txt" ] ; then
echo skipping gui
mkxpopt=linux
else
echo mkxpz;
mkxpzdialogoptions
fi
else
if [ -n "$SteamEnv" ] && [ -f "$HOME/.config/steamskipgui.txt" ] ; then
echo skipping gui
else
guirpgmakermfn
fi
fi
fi
# exit;


debuggamelibs() {
if [ "$found" = "true" ]; then

if [ "$gamepath" = "true" ]; then
nwdllpath="$path/nw.dll"
nodedllpath="$path/node.dll"
else
nwdllpath="nw.dll"
nodedllpath="node.dll"
fi
# echo "$mountpath"
rpgmvcorefilepath="$mountpath/js/rpg_core.js"
rpgmzcorefilepath="$mountpath/js/rmmz_core.js"

if [ -f "$rpgmvcorefilepath" ]; then
rpgcorefilepath="$rpgmvcorefilepath"
elif [ -f "$rpgmzcorefilepath" ]; then
rpgcorefilepath="$rpgmzcorefilepath"
fi

if [ -f "$nwdllpath" ]; then
nwdlltext=$("$stringsbin" "$nwdllpath")
nwjsversiondll=$(echo "$nwdlltext" | sed -n "s/process.versions\['nw'\] = '//p" | sed -e "s@'.*@@g")
chromiumversion=$(echo "$nwdlltext" | grep -B 4 '::SHGetSpecialFolderPathW' | grep '\.[0-9]\.[0-9]' | sed -e 's@.*\.\$@@g')
fi
rpgcoretext=$(cat "$rpgcorefilepath")
if [ -f "$nodedllpath" ]; then
nodeversion=$("$stringsbin" "$nodedllpath" | grep '/win-.*/node.lib' | sed -e 's@https://nodejs.org/download/release/@@g' -e 's@/win-.*/node.lib@@g')
fi

rpgmakername=$(echo -e "$rpgcoretext" | sed -n "s/Utils.RPGMAKER_NAME = .//p" | sed -e 's@.;@@g')
rpgmakerversion=$(echo -e "$rpgcoretext" | sed -n 's/Utils.RPGMAKER_VERSION = .//p' | sed -e 's@.;@@g')
if [ -n "$nwjsversiondll" ]; then
echo NWJS version - $nwjsversiondll
fi
if [ -n "$chromiumversion" ]; then
echo Chromium version - $chromiumversion
fi

if [ -n "$nodeversion" ]; then
echo Node version - $nodeversion
fi

if [ -n "$nodeversion" ]; then
echo Node version - $nodeversion
fi

if [ -n "$rpgmakername" ]; then
echo RPG Maker Name - $rpgmakername
fi


if [ -n "$rpgmakerversion" ]; then
echo RPG Maker version - $rpgmakerversion
fi

if [ -n "$nwjsversiondll" ] && [ -z "$skipffmpeginfo" ] ; then
echo "
ffmpeg prebuild link
https://github.com/nwjs-ffmpeg-prebuilt/nwjs-ffmpeg-prebuilt/releases/tag/$nwjsversiondll"
fi

else
echo "Can't find the game path"
fi
}


if [ "$printrpgmakerlibversions" = "true" ]; then
debuggamelibs
fi


if [ "$info" = true ]; then
exit;
fi
# echo "$forceaarch"



if [ -z "$cicpoffspath" ]; then
cicpoffs="$mainfd/nwjs/nwjs/cicpoffs"
fi

nwjslist=$(ls -p "$nwjsfm/nwjs/" | grep /)

if [ -f "$nwjsfm/packagefiles/usesdk.txt" ]; then
nwjslistd=$(echo "$nwjslist" | grep "sdk")
# export latestlocal=$(echo "$nwjssdkonlylist" | tail -n 1 | sed -e 's@nwjs-sdk-@@g' -e 's@-linux.*@@g' )

else
nwjslistd=$(echo "$nwjslist" | grep -v "sdk")
fi

if [ "$latestnwjs" = "true" ]; then
nwjsf="$latestinstallednwjsfd"
else
nwjsf=$(ls -tp "$defp" | grep / | head -n 1 | sed -e 's@/$@@g')
fi
if [ -n "$NWJSPATH" ]; then
nwjstestpath="$NWJSPATH"
echo "$NWJSPATH"
else
if [ -n "$nwjsversion" ]; then
nwjsf=$(echo "$nwjslistd" | grep "$nwjsversion" )
# nwjstestpath="$defp/nwjs/$nwjsversion"
if [ -n "$nwjsf" ]; then
# echo "$nwjsf"
nwjstestpath="$nwjsfm/nwjs/$nwjsf"
# kdialog --msgbox "$nwjstestpath"
else
echo no version
fi
else
if [ -z "$nwjsf" ]; then
nonwjs=true
fi
nwjstestpath="$defp/$nwjsf"
fi
fi

nwjstestpath=$(echo "$nwjstestpath" | sed -e 's@/$@@g')
# wwwsavesymlink.sh "$@"
# echo "$nwjstestpath"


if [ "$BUGREPORT" = "true" ]; then
export gamefdname=$(basename "$npath")
export lsdatalink=$(ls "$npath" | wget --quiet -O- --post-data "$(cat)" https://paste.c-net.org/)
if [ -n "$found" ]; then
export debuggamelibsdata=$(debuggamelibs)
export pluginsfilepastebin=$(wget --quiet -O- --post-file="$mountpath/js/plugins.js" 'https://paste.c-net.org/')
export packagejson=$(wget --quiet -O- --post-file="$npath/package.json" 'https://paste.c-net.org/')
export engine=rpgm
elif [ "$engine" = "tyrano" ]; then
export engine=tyrano
elif [ "$engine" = "mkxpz" ]; then
export engine=mkxpz
 echo -e "mkxp is a project that seeks to provide a fully open source implementation of the Ruby Game Scripting System (RGSS) interface used in the popular game creation software RPG Maker XP, RPG Maker VX and RPG Maker VX Ace (trademark by Enterbrain, Inc.), with focus on Linux.\nThe goal is to be able to run games created with the above software natively without changing a single file.\n\nIt is licensed under the GNU General Public License v2+.\n\nShould I use mkxp\nmkxp primarily targets technically versed users that are comfortable with Ruby / RGSS, and ideally know how to compile the project themselves.\nThe reason for this is that for most games, due to Win32-API usage, mkxp is simply not a plug-and-play solution, but a building block with which a fully cross-platform version can be created in time.\n\nHow can I fix the problem with the game?\nYou can ask the members of the Discord group and send them the log.\nAlternatively, you can search for game patches on google with the tag mkxp.\nFor example “Your game name + mkxp patches”\n\nGame engine social media links:\nhttps://github.com/mkxp-z/mkxp-z\nhttps://discord.gg/A8xHE8P\nhttps://matrix.to/#/#rpgmaker:mapleshrine.eu\nhttps://github.com/bakustarver/rpgmakermlinux-cicpoffs/issues" | "$yadp" --text-info --width=600 --height=480 --title "Information about the engine"
elif [ "$engine" = "construct-nwjs" ]; then
export engine=construct-nwjs
fi
if [ -n "$found" ] || [ -n "$engine"  ]; then
"$nwjsfm/packagefiles/bugreporter"
else
echo "Cannot find any game"
fi
exit;
fi

if [ "$EXPORTTHEGAME" = "true" ] && [ "$found" = "true" ]; then
defexportpath="$HOME/Your_exported_games"
thegamebasename=$(basename "$npath" | sed -e "s@\$@-linux-$arch@g")
theexpgamep="$defexportpath/$thegamebasename"
if ! [ -d "$theexpgamep" ]; then
mkdir -p "$theexpgamep/www"
fi;
if ! [ -d "$theexpgamep" ]; then
mkdir -p "$theexpgamep/www-case"
fi;
cp -r "$nwjstestpath"/* "$theexpgamep/"
if ! [ -d "$theexpgamep" ]; then
mkdir -p "$theexpgamep/lib"
fi;
cp "$cicpoffs" "$theexpgamep/lib"
cp "$nwjsfm/packagefiles/libulockmgr.so.1" "$theexpgamep/lib"
cp "$mainfd/nwjs/nwjs/packagefiles/package.json" "$theexpgamep"
cp "$nwjsfm/packagefiles/filestoexport/start_your_game.sh" "$theexpgamep"
cp -r "$mountpath" "$theexpgamep/www-case"

  # Loop through files and folders in the game directory
for item in "$mountpath"/*; do
      # Get the basename of the item and convert it to lowercase
    base0=$(basename "$item" )
    base=$(echo "$base0" | tr '[:upper:]' '[:lower:]')
    echo "$item - $base"
    # Check if the lowercase basename is in the lowercase exclude list
    if [[ " ${exclude_list[@]} " =~ " ${base} " ]]; then
#         echo "cc $item - $base"
        rm -rf "$theexpgamep/www-case/$base0"
    fi
done

# "$mountpath"
exit;
fi




startnw() {
# cd "$gamef" &
versionnum=$(echo "$nwjsf" | sed -e 's@.*v0\.@@g' -e 's@\..*@@g')
# echo "version $nwjsf $versionnum"
echo "$nwjsf"
if [ "$versionnum" -lt 102 ]; then
"$nwjstestpath/nw" --ozone-platform=x11
else
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
echo "wayland detected"
"$nwjstestpath/nw" --ozone-platform=wayland
else
echo "wayland not detected, starting in x11"
"$nwjstestpath/nw" --ozone-platform=x11
fi
fi

}



#Unmount folder

checkandunmount() {


if ! [ -d "$nwjstestpath/www" ]; then
mkdir -p "$nwjstestpath/www"
fi;
if [ -z "$unmount" ]; then
testf=$(findmnt "$nwjstestpath/www");
if [ -n "$testf" ]; then
fusermount -u "$nwjstestpath/www"
fi
fi
}


rmsymlinks () {
# rm "$nwjstestpath/package.json";
rm "$nwjstestpath/www"
}

mountwww() {
packagejsonfunc
if ! [ -h "$nwjstestpath/data" ] && [ -h "$nwjsfm/packagefiles/data" ]; then
# echo hello;
cp -a "$nwjsfm/packagefiles/data" "$nwjstestpath/data"
fi

if [ -h "$nwjstestpath/www" ]; then
rm "$nwjstestpath/www"
fi
if ! [ -d "$nwjstestpath/www" ] && [ -z "$nonwjs" ]; then
mkdir -p "$nwjstestpath/www"
fi;

echo "$cicpoffs" "$mountpath" "$nwjstestpath/www"
"$cicpoffs" "$mountpath" "$nwjstestpath/www"

SECONDS=0;
while ! [ -d "$nwjstestpath/www/js" ]; do

sleep 1
echo Mounting the folder: Time passed $SECONDS seconds;
done
echo -e "Mounting done.
Total time: $SECONDS seconds"

}


checkreaddirSynfunc() {
for file in "$nwjstestpath"/*; do
  if [ -L "$file" ]; then
    rm -f "$file"
  fi
done

if grep -q -r "readdirSyn" "$mountpath/js/plugins/"; then

# echo hhh;
for file in "$npath"/*; do

        base0=$(basename "$file" )
        base=$(echo "$base0" | tr '[:upper:]' '[:lower:]')

    if ! [[ " ${exclude_list[@]} " =~ " ${base} " ]]; then

        ln -s "$file" "$nwjstestpath"
    fi
done

fi

}


plugins-autoinstall() {
cpfd="$nwjsfm/plugins-autoinstall"
pluginslistfile="$mountpath/js/plugins.js"
# echo ggvv
if [ -n "$(ls -A "$cpfd/js/plugins" )" ] && [ -s "$cpfd/pluginsconf.txt" ] && ! [ -f "$mountpath/pluginsconf.txt" ] ; then
# echo "hellovvvv"
pluginset=$(cat "$cpfd/pluginsconf.txt")
cp -r "$cpfd"/* "$mountpath/"
cp "$pluginslistfile" "$pluginslistfile.bk"
sed -e "s@^\[@[\n$pluginset@g" -i "$pluginslistfile"
# rm "$mountpath/pluginsconf.txt"
fi
}

if [ "$INSTALLPIXI5" = "true" ]; then
pixi5install;
fi


if [ "$FIVEHUNDREDSAVESLOTSPLUGIN" = "true" ]; then
fivehundredslotsplugininstall;
fi

if [ "$INSTALLTHPL" = "true" ]; then
texthookerplugininstall;
elif [ "$INSTALLTHPL" = "false" ]; then
texthookerpluginuninstall
fi
# kdialog --msgbox "ggg $nwjstestpath"


checkandunmount

checkthebinaryarch "$cicpoffs"

checkthebinaryarch "$nwjstestpath/nw"




if [ "$engine" = "tyrano" ]; then
if [ "$usetyranoelectron" = "true" ]; then
"$electronfd/electron"
else
ln -s "$ndmodulesfd" "$nwjstestpath"
ln -s "$mainfd/nwjs/nwjs/packagefiles/tyranobuilder/tyranoeng" "$nwjstestpath"
cat "$mainfd/nwjs/nwjs/packagefiles/tyranobuilder/package.json" > "$nwjstestpath/package.json"
startnw
fi
elif [ "$engine" = "mkxpz" ]; then

mkxpfunc
elif [ "$engine" = "nscripter" ]; then
"$nwjsfm/packagefiles/onsyuri/onsyuri" --root "$npath" --font "$nwjsfm/packagefiles/onsyuri/umeplus-gothic.ttf"
elif [ "$engine" = "construct-nwjs" ]; then

if [ -f "$nwjstestpath/package.nw" ]; then
rm "$nwjstestpath/package.nw"
fi
if [ -f "$nwjstestpath/package.json" ]; then
rm "$nwjstestpath/package.json"
fi
ln -s "$npath/package.nw" "$nwjstestpath"
startnw
elif [ "$found" = "true" ]; then
checkreaddirSynfunc



if [ "$CICPOFFSMOUNT" = "true" ]; then
mountwww
elif [ "$NOMOUNT" = "true" ]; then
:
else

checkandunmount
packagejsonfunc
# echo "$nwjstestpath/www"
rm -rf "$nwjstestpath/www"
ln -s "$mountpath" "$nwjstestpath/www"

fi
plugins-autoinstall
if [ -n "$MAKELOCALSHORTCUT" ]; then
makelocalshortcut
fi
if [ -n "$MAKEDESKTOPSHORTCUT" ]; then
makedesktopshortcut
fi
if [ -n "$ADDTOTHEMENU" ]; then
makethemenushortcut
fi
startnw
# sleep 60;
checkandunmount
fi


if [ -n "$notfound" ]; then
echo "Can't find any game in $npath"
exit 1
fi
