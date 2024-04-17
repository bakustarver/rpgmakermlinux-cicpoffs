#!/bin/bash

export LD_LIBRARY_PATH="$HOME/desktopapps/nwjs/nwjs/packagefiles/:$LD_LIBRARY_PATH"

# kdialog --msgbox "$CPATH"

# curdesktop=$(echo "$XDG_CURRENT_DESKTOP")
# defp="$HOME/deskappbin/nwjs/nwjs/"
version='1.0.4'

nwjsfm="$HOME/desktopapps/nwjs/nwjs"

defp="$nwjsfm/nwjs"

nwjslist=$(ls -p "$defp" | grep / | sort -V)
if [ -z "$nwjslist" ]; then
echo "the nwjs is not installed, please use $ rpgmaker-linux --installnwjs"
fi
if echo "$nwjslist" | grep -q "\-sdk"; then
# sdkinstalled=true
nwjsonlylist=$(echo "$nwjslist" | grep -v "sdk")
nwjssdkonlylist=$(echo "$nwjslist" | grep "sdk")
latestinstallednwjsfd=$(echo "$nwjssdkonlylist" | sort -V | uniq | tail -n 1)
else
latestinstallednwjsfd=$(echo "$nwjslist" | tail -n 1)
fi
echo "$latestinstallednwjsfd"
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
archcheckmessage=$(echo "$arch" | sed -e 's@x86_64@pie executable, x86-64,@g' -e 's@aarch64@pie executable, ARM aarch64,@g' -e 's@i686@pie executable, Intel 80386,@g' -e 's@i386@pie executable, Intel 80386,@g' -e 's@armv7l@pie executable, ARM,@g' -e 's@armhf@pie executable, ARM,@g')

checkthebinaryarch() {
if ! [ -f "$1" ]; then
echo "Missing file $1"
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

sourcelinks() {

echo "Github page
https://github.com/bakustarver/rpgmakermlinux-cicpoffs

Patreon page
https://www.patreon.com/user/about?u=121421184

Buymeacoffe page
https://www.buymeacoffee.com/rpgmakerlinux"
}

incompletefeaturefunc() {
echo "$arg" in development, wait for it on this site.
echo "https://github.com/bakustarver/rpgmakermlinux-cicpoffs"
}


fullupdatereinstall() {
echo "$githubscriptwget" | bash
}



updatenwjs() {
if [ -f "$nwjsfm/packagefiles/usesdk.txt" ]; then
export latestlocal=$(echo "$nwjssdkonlylist" | tail -n 1 | sed -e 's@nwjs-sdk-@@g' -e 's@-linux.*@@g' )

"$nwjsfm/dwnwjs.sh"
else
export latestlocal=$(echo "$latestinstallednwjsfd" | sed -e 's@nwjs-@@g' -e 's@-linux.*@@g')
"$nwjsfm/dwnwjs.sh"
fi
}

nwjsversionfunc() {
export skipdownloadifexist=true
. "$nwjsfm/dwnwjs.sh" "$1"
# nwjsversion=(echo "$nwjsversion"
}

checkifexist() {
if ! [ -f "$1" ]; then
echo "Can't find the file $1"
exit
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

checkgamefilesfd() {
if echo "$1" | grep ".exe"; then
npath=$(dirname "$1" | sed -e "s@^'@@g");
else
npath="$1"
fi
# zenity --title "$gamef" --warning --text="$npath"
if [ -d "$npath/www" ] && [ -e "$npath/package.json" ] && [ -e "$npath/www/js/plugins.js" ]; then
mountpath="$npath/www"
found=true
gamepath=true
elif [ -d "$npath/data" ] && [ -e "$npath/package.json" ] && [ -e "$npath/js/plugins.js" ]; then
mountpath="$1"
gamepath=true
found=true
else
echo "Can't find game with $1"
exit 1
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

if [ -z "$gamepath" ]; then
if [ -d ./www ] && [ -f ./package.json ]; then
mountpath="$PWD/www"
found=true
elif [ -d ./js ] && [ -f ./package.json ] &&  [ -d ./data ]; then
mountpath="$PWD"
found=true
fi
fi
#
if [ -z "$found" ] && [ -n "$gamef" ] ; then
checkgamefilesfd "$gamef"
fi



checknwjspath() {
path="$1"
if [ -d "$path/lib" ] && [ -e "$path/nw" ]; then
NWJSPATH="$path"
else
echo "Can't find NWJS"
exit 1
fi
}

checkcicpoffspath() {
path="$1"
if [ -e "$path" ]; then
cicpoffs="$path"
cicpoffspath="true"
else
echo "Can't find cicpoff"
exit 1
fi
}

packagejsonfunc() {
if [ -n "$PACKAGEJSONPATH" ]; then
packagejson="$PACKAGEJSONPATH"
else
packagejson="$HOME/desktopapps/nwjs/nwjs/packagefiles/package.json"
fi
packagejsoninfo=$(cat "$packagejson")
newpackagejson=$(echo "$packagejsoninfo" | sed -e 's@"name": "",@"name": "RPG Maker MV/MZ (cicpoffs mount)",@g' -e 's@"main": ".*@"main": "www/index.html",@' -e 's@"title": "",@"title": "RPG Maker MV/MZ (cicpoffs mount)",@g')
# ln -s "$packagejson" "$nwjstestpath"
if [ -h "$nwjstestpath/package.json" ]; then
rm "$nwjstestpath/package.json"
fi
echo "$newpackagejson" > "$nwjstestpath/package.json"
}


while [ $# -ne 0 ]
do
    arg="$1"
    arg2="$2"
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
        --usestandart)
#             export SDKNWJS=true
            if [ -e "$nwjsfm/packagefiles/usesdk.txt" ]; then
            rm "$nwjsfm/packagefiles/usesdk.txt"
            fi
            ;;
        --pixi5install)
            INSTALLPIXI5=true
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
        --choosenwjsversion)
            nwjsversionfunc "$2"
            ;;
        --clearoldnwjs)
            clearoldnwjs=true
            incompletefeaturefunc
            ;;
        --updatenwjs)
            updatenwjs
            ;;
        --fullupdate)
            fullupdatereinstall
            ;;
        --updatescripts)
            disableCopperBld=true
            incompletefeaturefunc
            ;;
        --unmount)
            case "$arg2" in
                false)
                    unmount=false
                    ;;
                *)
                    echo -e "Use --unmount false
                    --unmount true"
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
            echo "Can't find the original package.json"
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
            LANG="ja_JP.utf8"
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
echo -e "RPGMaker MV/MZ linux $version

https://github.com/bakustarver/rpgmakermlinux-cicpoffs

--help
--version
--updatenwjs
--chooselatestnwjs
--nwjsversion
--clearoldnwjs
--unmount
--gamepath
--useoriginalgamepackagejson
--custompackagejsonpath
--nwjspath
--cicpoffspath
--printrpgmakerlibversions
--forceaarch
--jpnlocale
--checkreleaseupdates
--checkbetaupdates
--updatescripts
--fullupdate
--sourcelinks
--usesdk
--pixi5install"
fi




if [ "$printrpgmakerlibversions" = "true" ]; then
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


nwdlltext=$(strings "$nwdllpath")
rpgcoretext=$(cat "$rpgcorefilepath")
nodeversion=$(strings "$nodedllpath" | grep '/win-.*/node.lib' | sed -e 's@https://nodejs.org/download/release/@@g' -e 's@/win-.*/node.lib@@g')
nwjsversiondll=$(echo "$nwdlltext" | sed -n "s/process.versions\['nw'\] = '//p" | sed -e "s@'.*@@g")
chromiumversion=$(echo "$nwdlltext" | grep -B 4 '::SHGetSpecialFolderPathW' | grep '\.[0-9]\.[0-9]' | sed -e 's@.*\.\$@@g')
rpgmakername=$(echo -e "$rpgcoretext" | sed -n "s/Utils.RPGMAKER_NAME = .//p" | sed -e 's@.;@@g')
rpgmakerversion=$(echo -e "$rpgcoretext" | sed -n 's/Utils.RPGMAKER_VERSION = .//p' | sed -e 's@.;@@g')


echo "NWJS version - $nwjsversiondll
Chromium version - $chromiumversion
Node version - $nodeversion
RPG Maker Name - $rpgmakername
RPG Maker version - $rpgmakerversion

ffmpeg prebuild link
https://github.com/nwjs-ffmpeg-prebuilt/nwjs-ffmpeg-prebuilt/releases/tag/$nwjsversiondll"
else
echo "Can't find the game path"
fi
fi


if [ "$info" = true ]; then
exit;
fi
# echo "$forceaarch"


if [ -z "$cicpoffspath" ]; then
cicpoffs="$HOME/desktopapps/nwjs/nwjs/cicpoffs"
fi

if [ "$latestnwjs" = "true" ]; then
nwjsf="$latestinstallednwjsfd"
else
nwjsf=$(ls -tp "$defp" | grep / | head -n 1)
fi
if [ -n "$NWJSPATH" ]; then
nwjstestpath="$NWJSPATH"
echo "$NWJSPATH"
else
if [ -n "$nwjsversion" ]; then
nwjstestpath="$defp/nwjs/$nwjsversion"
else
nwjstestpath="$defp/$nwjsf"
fi
fi

# wwwsavesymlink.sh "$@"
# echo "$nwjstestpath"





startnw() {
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
echo "wayland detected"
"$nwjstestpath/nw" --ozone-platform=wayland
else
echo "wayland not detected, starting in x11"
"$nwjstestpath/nw" --ozone-platform=x11
fi
}



#Unmount folder

checkandunmount() {
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
if ! [ -d "$nwjstestpath/www" ]; then
mkdir -p "$nwjstestpath/www"
fi;

"$cicpoffs" "$mountpath" "$nwjstestpath/www"

SECONDS=0;
while ! [ -d "$nwjstestpath/www/js" ]; do

sleep 1
echo Mounting the folder: Time passed $SECONDS seconds;
done
echo -e "Mounting done.
Total time: $SECONDS seconds"

}

if [ "$INSTALLPIXI5" = "true" ]; then
pixi5install
fi

checkandunmount
checkthebinaryarch "$cicpoffs"
checkthebinaryarch "$nwjstestpath/nw"

if [ "$found" = "true" ]; then
# rmsymlinks
mountwww
startnw
checkandunmount
fi
