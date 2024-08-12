#!/bin/bash


export LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH"

cicpoffs=lib/cicpoffs

startnw() {
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
echo "wayland detected"
"./nw" --ozone-platform=wayland
else
echo "wayland not detected, starting in x11"
"./nw" --ozone-platform=x11
fi
}

if [ -f "lib/cicpoffs" ]; then
echo "$cicpoffs" www-case www
"$cicpoffs" www-case www

SECONDS=0;
while ! [ -d "./www/js" ]; do

sleep 1
echo Mounting the folder: Time passed $SECONDS seconds;
done
echo -e "Mounting done.
Total time: $SECONDS seconds"
else
echo "Unable to find the cicpoffs"
fi

if [ -f "nw" ]; then

# ./nw
startnw
else
echo "Unable to find the nwjs"
fi

fusermount -u "www"
