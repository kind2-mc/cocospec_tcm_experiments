#!/bin/bash

git clone https://github.com/kind2-mc/kind2
cd kind2
./autogen.sh
./build.sh
cp bin/kind2 ../.
