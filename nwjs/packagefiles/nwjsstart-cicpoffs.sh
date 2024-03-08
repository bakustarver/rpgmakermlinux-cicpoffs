#!/bin/bash


# curdesktop=$(echo "$XDG_CURRENT_DESKTOP")
# defp="$HOME/deskappbin/nwjs/nwjs/"
nwjsfm="$HOME/desktopapps/nwjs/nwjs"

defp="$nwjsfm/nwjs"

arch=$(uname -m)
archcheckmessage=$(echo "$arch" | sed -e 's@x86_64@pie executable, x86-64,@g' -e 's@aarch64@pie executable, ARM aarch64,@g' -e 's@i686@pie executable, Intel 80386,@g' -e 's@i386@pie executable, Intel 80386,@g' -e 's@armhf@pie executable, ARM,@g')
version="1.0.0"
latestinstallednwjsfd=$(ls -p "$defp" | grep / | sort -V | tail -n 1 )

checkthebinaryarch() {
if ! [ -f "$1" ]; then
echo "Missing file $1"
fi

if ! file "$1" | grep -q "$archcheckmessage" ; then
# Use $ wget -qO- installscript.sh | bash
file "$1"
echo "Wrong architecture!!
Download corrent archive with $arch"
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


updatenwjs() {
export latestlocal=$(echo "$latestinstallednwjsfd" | sed -e 's@nwjs-@@g' -e 's@-linux.*@@g')
"$nwjsfm/dwnwjs.sh"
}

nwjsversionfunc() {
export skipdownloadifexist=true
. "$nwjsfm/dwnwjs.sh" "$1"
# nwjsversion=(echo "$nwjsversion"
}

checkgamepath() {
# path="$1"
echo "$1"

if [ -f "$1" ]; then
path=$(readlink -f "$1")
elif [ -d "$1" ]; then
path=$(echo "$1")
else
echo "Use "$arg' "/path/rpggame/"'
exit 1
fi

if [ -d "$path/www" ] && [ -e "$path/package.json" ] && [ -e "$path/www/js/plugins.js" ]; then
mountpath="$path/www"
found=true
gamepath=true
elif [ -d "$path/data" ] && [ -e "$path/package.json" ] && [ -e "$path/js/plugins.js" ]; then
mountpath="$path"
gamepath=true
found=true
else
echo "Can't find game with $arg"
exit 1
fi
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
            checkgamepath "$2"
            ;;
        --usegamepackagejson)
            usegamepackagejson=true
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
--usegamepackagejson
--nwjspath
--cicpoffspath
--printrpgmakerlibversions
--forceaarch
--jpnlocale
--checkreleaseupdates
--checkbetaupdates
--updatescripts
--sourcelinks"
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

nwdlltext=$(strings "$nwdllpath")
nodeversion=$(strings "$nodedllpath" | grep '/win-.*/node.lib' | sed -e 's@https://nodejs.org/download/release/@@g' -e 's@/win-.*/node.lib@@g')
nwjsversiondll=$(echo "$nwdlltext" | sed -n "s/process.versions\['nw'\] = '//p" | sed -e "s@'.*@@g")
chromiumversion=$(echo "$nwdlltext" | grep -B 4 '::SHGetSpecialFolderPathW' | grep '\.[0-9]\.[0-9]' | sed -e 's@.*\.\$@@g')

echo "NWJS version - $nwjsversiondll
Chromium version - $chromiumversion
Node version - $nodeversion

ffmpeg prebuild link
https://github.com/nwjs-ffmpeg-prebuilt/nwjs-ffmpeg-prebuilt/releases/tag/$nwjsversion"
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
packagejson="$HOME/desktopapps/nwjs/nwjs/packagefiles/package.json"

if [ "$latestnwjs" = "true" ]; then
nwjsf="$latestinstallednwjsfd"
else
nwjsf=$(ls -tp "$defp" | grep / | head -n 1)
fi
if [ -n "$nwjsversion" ]; then
nwjstestpath="$defp/nwjs/$nwjsversion"
else
nwjstestpath="$defp/$nwjsf"
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
ln -s "$packagejson" "$nwjstestpath"
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

checkandunmount
checkthebinaryarch "$cicpoffs"
checkthebinaryarch "$nwjstestpath/nw"

if [ "$found" = "true" ]; then
# rmsymlinks
mountwww
startnw
checkandunmount
fi
