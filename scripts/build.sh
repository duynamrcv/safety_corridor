#!/bin/sh

cmake -S . -Bbuild -GNinja -DCMAKE_BUILD_TYPE=Debug

ln -sf build/compile_commands.json .

ninja -C build -j 8
