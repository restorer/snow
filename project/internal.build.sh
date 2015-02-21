#!/bin/bash
#fail on errors
set -e

#This file is used for continuous integration only and shouldn't be called directly.
#To build manually read the snow docs and run `flow build --options` as usual.
# https://underscorediscovery.github.io/snow/guide/native-layer.html

#ensure dependencies are down
git submodule update --init

#jump to correct folder for builds
cd project

#64 bit if specified
if [ -n "$SNOW_BUILD_ARCH_64" ] then
    haxelib run flow build --arch 64 --d static_link --log $SNOW_BUILD_LOG_LEVEL
    haxelib run flow build --arch 64 --d snow_dynamic_link --log $SNOW_BUILD_LOG_LEVEL
fi

if [ -n "$SNOW_BUILD_ARCH_32" ] then
    haxelib run flow build --arch 32 --d static_link --log $SNOW_BUILD_LOG_LEVEL
    haxelib run flow build --arch 32 --d snow_dynamic_link --log $SNOW_BUILD_LOG_LEVEL
fi

if [ -n "$SNOW_BUILD_ANDROID" ] then
    haxelib run flow build android --arch armv6 --d snow_dynamic_link --log $SNOW_BUILD_LOG_LEVEL
    haxelib run flow build android --arch armv7 --d snow_dynamic_link --log $SNOW_BUILD_LOG_LEVEL
    haxelib run flow build android --arch x86 --d snow_dynamic_link --log $SNOW_BUILD_LOG_LEVEL
fi

if [ -n "$SNOW_BUILD_IOS" ] then
    haxelib run flow build ios --archs armv6,armv7,armv7s,arm64,sim,sim64 --d static_link --log $SNOW_BUILD_LOG_LEVEL
fi

#revert to play nice
cd ..