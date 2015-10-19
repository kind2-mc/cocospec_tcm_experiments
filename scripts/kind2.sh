#!/bin/bash

git clone https://github.com/kind2-mc/kind2
cd kind2
git checkout contracts-and-arrays
./autogen.sh
./build.sh
cp bin/kind2 ../.
