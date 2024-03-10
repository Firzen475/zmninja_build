#!/usr/bin/env bash

rm -rf ./zmninja/
mkdir -p ./zmninja/
git clone --depth 1 https://github.com/zoneminder/zmninja.git ./zmninja/
rm -rf ./release/
mkdir -p ./release/
