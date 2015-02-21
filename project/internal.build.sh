
#This file is used for continuous integration only and shouldn't be called directly.
#To build manually read the snow docs and run `flow build --options` as usual.
# https://underscorediscovery.github.io/snow/guide/native-layer.html

cd project
flow build
flow build --d snow_dynamic_link
cd ..