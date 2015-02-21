
#This file is used for continuous integration only and shouldn't be called directly.
#To build manually read the snow docs and run `flow build --options` as usual.
# https://underscorediscovery.github.io/snow/guide/native-layer.html

#ensure dependencies are down
git submodule update --init

#jump to correct folder for builds
cd project
#build host arch, static
haxelib run flow build --d static_link --log 3
#build dynamic
haxelib run flow build --d snow_dynamic_link --log 3

#revert to play nice
cd ..