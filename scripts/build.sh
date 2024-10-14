#!/bin/sh

cmake -S . -Bbuild -GNinja -DCMAKE_BUILD_TYPE=Debug

ninja -C build -j 8
