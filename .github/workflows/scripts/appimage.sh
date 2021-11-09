#!/bin/bash -ex

BRANCH=`echo ${GITHUB_REF##*/}`
BINARY=Vita3K

mkdir -p AppDir/usr/bin
cp build/bin/"$BINARY" AppDir/usr/bin
cp -r build/bin/{data,lang,shaders-builtin} AppDir/usr/bin 
cp data/image/icon.png AppDir/"$BINARY".png
cp .github/workflows/scripts/"$BINARY".desktop AppDir/"$BINARY".desktop
#cp AppDir/update.sh
#cp AppDir/AppRun
curl -sL https://github.com/AppImage/AppImageKit/releases/download/continuous/AppRun-x86_64 -o AppDir/AppRun
curl -sL https://github.com/AppImage/AppImageKit/releases/download/continuous/runtime-x86_64 -o ./AppDir/runtime
mkdir -p AppDir/usr/share/applications && cp ./AppDir/"$BINARY".desktop ./AppDir/usr/share/applications
mkdir -p AppDir/usr/share/icons && cp ./AppDir/"$BINARY".png ./AppDir/usr/share/icons
mkdir -p AppDir/usr/share/icons/hicolor/scalable/apps && cp ./AppDir/"$BINARY".png ./AppDir/usr/share/icons/hicolor/scalable/apps
mkdir -p AppDir/usr/share/pixmaps && cp ./AppDir/"$BINARY".png ./AppDir/usr/share/pixmaps
#mkdir -p AppDir/usr/optional/ ; mkdir -p AppDir/usr/optional/libstdc++/
#mkdir -p AppDir/usr/share/zenity 
#cp /usr/share/zenity/zenity.ui ./AppDir/usr/share/zenity/
#cp /usr/bin/zenity ./AppDir/usr/bin/
#cp /usr/bin/realpath ./AppDir/usr/bin/

#curl -sL https://github.com/RPCS3/AppImageKit-checkrt/releases/download/continuous2/exec-x86_64.so -o ./AppDir/usr/optional/exec.so
#cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 AppDir/usr/optional/libstdc++/

chmod a+x ./AppDir/AppRun
#chmod a+x ./AppDir/AppRun-patched
chmod a+x ./AppDir/runtime
chmod a+x ./AppDir/usr/bin/"$BINARY"
#chmod a+x ./AppDir/update.sh

#curl -sLO https://raw.githubusercontent.com/$GITHUB_REPOSITORY/$BRANCH/.travis/update.tar.gz
#tar -xzf update.tar.gz
#mv update/AppImageUpdate ./AppDir/usr/bin/
#mkdir -p AppDir/usr/lib/
#mv update/* ./AppDir/usr/lib/

echo $name > ./AppDir/version.txt


ls -al ./AppDir

wget "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
chmod a+x appimagetool-x86_64.AppImage
./appimagetool-x86_64.AppImage AppDir/ -u "gh-releases-zsync|qurious-pixel|"$BINARY"|continuous|"$BINARY"-x86_64.AppImage.zsync"

mkdir artifacts
mv "$BINARY"-x86_64.AppImage* artifacts