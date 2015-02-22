#!/bin/bash
#fail on errors
set -e

#This file is used for continuous integration only and shouldn't be called directly.
#To build manually read the snow docs and run `flow build --options` as usual.
# https://underscorediscovery.github.io/snow/guide/native-layer.html

#ensure dependencies are down
git submodule update --init


#64 bit if specified
if [ -n "$SNOW_BUILD_ARCH_64" ]
    then

    echo "snow; build; running arch 64..."
    haxelib run flow build --project project/snow.flow --arch 64 --d static_link --log "$SNOW_BUILD_LOG_LEVEL"
    haxelib run flow build --project project/snow.flow --arch 64 --d snow_dynamic_link --log "$SNOW_BUILD_LOG_LEVEL"

fi

if [ -n "$SNOW_BUILD_ARCH_32" ]
then

    echo "snow; build; running arch 32..."
    haxelib run flow build --project project/snow.flow --arch 32 --d static_link --log "$SNOW_BUILD_LOG_LEVEL"
    haxelib run flow build --project project/snow.flow --arch 32 --d snow_dynamic_link --log "$SNOW_BUILD_LOG_LEVEL"

fi

if [ -n "$SNOW_BUILD_ANDROID" ]
then

    echo "snow; build; running android archs armv6, armv7, x86 ..."
    haxelib run flow build android --project project/snow.flow --arch armv6 --d snow_dynamic_link --log "$SNOW_BUILD_LOG_LEVEL"
    haxelib run flow build android --project project/snow.flow --arch armv7 --d snow_dynamic_link --log "$SNOW_BUILD_LOG_LEVEL"
    haxelib run flow build android --project project/snow.flow --arch x86 --d snow_dynamic_link --log "$SNOW_BUILD_LOG_LEVEL"

fi

if [ -n "$SNOW_BUILD_IOS" ]
then

    echo "snow; build; running android archs armv6, armv7, armv7s, arm64, sim, sim64 ..."
    haxelib run flow build ios --project project/snow.flow --archs armv6,armv7,armv7s,arm64,sim,sim64 --d static_link --log "$SNOW_BUILD_LOG_LEVEL"

fi

#zip artifacts

case "$SNOW_BUILD_TARGET" in
    "linux32" ) zip -r ndll/latest.linux32.zip ndll/Linux/ -x ".*" -x "*/.*"
        ;;
    "linux64" ) zip -r ndll/latest.linux64.zip ndll/Linux64/ -x ".*" -x "*/.*"
        ;;
    "mac" ) zip -r ndll/latest.mac.zip ndll/Mac/ ndll/Mac64 -x ".*" -x "*/.*"
        ;;
    "windows" ) zip -r ndll/latest.windows.zip ndll/Windows/ -x ".*" -x "*/.*"
        ;;
    "android" ) zip -r ndll/latest.android.zip ndll/Android/ -x ".*" -x "*/.*"
        ;;
    "ios" ) zip -r ndll/latest.ios.zip ndll/iPhone/ -x ".*" -x "*/.*"
        ;;
    *) echo "build target is unknown : $SNOW_BUILD_TARGET"
esac

if [ -n "$SNOW_BUILD_PACKAGE_BINARY" ]
then

    buildbox-artifact download "ndll/latest.*.zip" ndll/
    unzip -o -d ndll/all "ndll/latest.*.zip"
    zip -r ndll/latest.all.zip ndll/all/ -x ".*" -x "*/.*"

fi

