#!/bin/bash
#fail on errors
set -e

#This file is used for continuous integration only and shouldn't be called directly.
echo "snow; Don't run this script directly, read inside the file for why."
#To build manually read the snow docs and run `flow build --options` as usual.
# https://underscorediscovery.github.io/snow/guide/native-layer.html

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

if [ -n "$SNOW_BUILD_PACKAGE_BINARY" ]
then

    buildkite-artifact download "ndll/*" ndll/all/ndll
    cd ndll/all
    zip -r latest.all.zip ndll/ -x ".*" -x "*/.*"
    cd ../../
    cp ndll/all/latest.all.zip /usr/share/nginx/html/snow/latest.all.zip

    echo "snow; build; done package"

fi

