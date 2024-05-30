#!/bin/bash

export LD_LIBRARY_PATH="$HOME/desktopapps/nwjs/nwjs/packagefiles/:$LD_LIBRARY_PATH"

# kdialog --msgbox "$CPATH"

# curdesktop=$(echo "$XDG_CURRENT_DESKTOP")
# defp="$HOME/deskappbin/nwjs/nwjs/"
version='1.0.8'


nwjsfm="$HOME/desktopapps/nwjs/nwjs"

yadp="$nwjsfm/packagefiles/yad"
evbunpack="$nwjsfm/packagefiles/evbunpack"


defp="$nwjsfm/nwjs"
export defpn="$nwjsfm"
export DWNWJSNODEBUG=true

nwjslist=$(ls -p "$defp" | grep /)

if [ -z "$nwjslist" ]; then
echo "the nwjs is not installed, please use $ rpgmaker-linux --installnwjs"
fi
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


makedesktopfile() {
# $mountpath
geticonpath=$(sed -n 's/.*"icon": "//p' "$nwjstestpath/package.json" | sed -e 's@"@@g')
if [ "$engine" = "mz" ] && [ -z "$PACKAGEJSONPATH" ]; then
geticonpath=$(echo "$geticonpath" | sed -e 's@www/@@g');
fi
# bmountpath=$(basename "$mountpath")
# if [ "$engine" = "mv" ]; then
# ndirname=$(dirname "$mountpath")
# # echo 1
# else
# ndirname="$mountpath"
# # echo 2
# fi
ndirname="$npath"


ndrbasen=$(basename "$ndirname")
iconpath="$ndirname/$geticonpath"
# kdialog --msgbox "$mountpath-$bmountpath\n$ndirname\n$iconpath"

if [ -z "$dsavepath" ]; then
dsavepath="$ndirname"
fi

getgamename="Your game" #$(basename "$mountpath")
# kdialog --msgbox "$iconpath"
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
npath=$(echo "$1" | sed -e 's@rpgmakermp:///@@g')
if echo "$npath" | grep ".exe"; then
npath=$(dirname "$npath" | sed -e "s@^'@@g");
else
npath="$npath"
fi
# zenity --title "$gamef" --warning --text="$npath"
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
else
echo "Can't find game with $npath"
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
engine=mv
npath="$PWD"
elif [ -d ./js ] && [ -f ./package.json ] &&  [ -d ./data ]; then
mountpath="$PWD"
found=true
engine=mz
npath="$PWD"
fi
fi
#
if [ -z "$found" ] && [ -n "$gamef" ] ; then
# kdialog --msgbox "$gamef"
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


# echo "$packagejson"
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
        --gui)
            GUIMENU=true
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
            export LANG="ja_JP.utf8"
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
--pixi5install
--installtexthookerplugin
--uninstalltexthookerplugin
--makeshortcut"
fi


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

if [ "$GUIMENU" = "true" ]; then
configgp="$HOME/desktopapps/rpgmaker-guiconfig.txt"
if [ -f "$configgp" ]; then
configgdata=$(cat "$configgp")
yaddata "$configgdata"
newversionlist=$(echo "$allversionsnwjs" | grep -v "^$nwjsguivar$" | sed "1s/^/$nwjsguivar\n/")
if [ -z "$newversionlist" ]; then
newversionlist="$allversionsnwjs"
fi
# kdialog --msgbox "$nwjsguivar\n--$newversionlist"
guim=$("$yadp" --title "RPG Maker MV/MZ Options" --text="Please choose your options:" --image="$HOME/desktopapps/nwjs/nwjs/packagefiles/nwjs128.png" --columns=5 --field "Update NWJS":chk $updatenwjsvar --form --field "Pixi5 Update":chk "$pixiupdatevar" --field="Shorcut Options::LBL" false --field "Local Shortcut":chk "$localshortcutvar" --form --separator=" " --item-separator="\n" --field="Versions::"CBE "$newversionlist" --field "500 Save Slots Plugin":chk "$fivehundredsaveslotspluginvar" --field "Texthooker Plugin":chk "$texthookerset" --field=" :LBL" false --field "Desktop Shortcut":chk "$desktopshortcut" --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field "Show in the Menu":chk "$addtomenuvar" --field "Use SDK version":chk "$sdkvar" --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false)
else
guim=$("$yadp" --title "RPG Maker MV/MZ Options" --text="Please choose your options:" --image="$HOME/desktopapps/nwjs/nwjs/packagefiles/nwjs128.png" --columns=5 --field "Update NWJS":chk true --form --field "Pixi5 Update":chk false --field="Shorcut Options::LBL" false --field "Local Shortcut":chk true --form --separator=" " --item-separator="\n" --field="Versions::"CBE "$allversionsnwjs" --field "500 Save Slots PSlugin":chk false --field "Texthooker Plugin":chk false --field=" :LBL" false --field "Desktop Shortcut":chk false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field "Show in the Menu":chk false --field "Use SDK version":chk false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false --field=" :LBL" false)
fi

if [ -n "$guim" ] ; then
echo "$guim" > "$configgp"
else
exit;
fi
yaddata "$guim"
echo "$guim"

# exit;
if [ "$fivehundredsaveslotspluginvar" = "TRUE" ]; then
# export LANG="ja_JP.utf8"
export FIVEHUNDREDSAVESLOTSPLUGIN=true
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

if [ "$sdkvar" = "TRUE" ]; then
if ! [ -f "$nwjsfm/packagefiles/usesdk.txt" ]; then
touch "$nwjsfm/packagefiles/usesdk.txt"
fi
elif [ "$sdkvar" = "FALSE" ]; then
if [ -f "$nwjsfm/packagefiles/usesdk.txt" ]; then
rm "$nwjsfm/packagefiles/usesdk.txt"
fi
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

fi
# exit;

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

searchpath=$(echo "$nwjslistd" | grep "$nwjsversion" )
# nwjstestpath="$defp/nwjs/$nwjsversion"
if [ -n "$searchpath" ]; then
nwjstestpath="$nwjsfm/nwjs/$searchpath"
# kdialog --msgbox "$nwjstestpath"
else
echo no version
fi
else
nwjstestpath="$defp/$nwjsf"
fi
fi

nwjstestpath=$(echo "$nwjstestpath" | sed -e 's@/$@@g')
# wwwsavesymlink.sh "$@"
# echo "$nwjstestpath"


unpackexe() {
gameexe="$1"
gameexefd="$1-extracted"
originalexe=$(echo "$1" | sed -e 's@\.exe@@g' -e 's@$@_original.exe-extracted@g')
"$evbunpack" "$gameexe" "$gameexefd"
# find "$gameexefd" -type f \( -name "*.exe" \) -delete
cp -r "$gameexefd"/* "$npath"
mkdir "$originalexe"
}

searchforpackedexe() {
gfexe=$(ls "$1" | grep "\.exe$")
while IFS= read -r line; do
# check=$()
if ! [ -d "$npath/$line-extracted" ]; then

if strings "$npath/$line" | grep -q "\.enigma"; then
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
}



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
if ! [ -d "$nwjstestpath/www" ]; then
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


if [ "$found" = "true" ]; then
# rmsymlinks
searchforpackedexe "$npath"
mountwww
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
