#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

version="$1"

wget "https://www.python.org/ftp/python/$version/Python-$version.tgz"

tar xzf Python-$version.tgz

cd Python-$version

./configure

make && make install

# Cleanup
cd ../..
rm -rf tmp
