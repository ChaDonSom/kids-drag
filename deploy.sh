#!/bin/bash

sed -i 's/\/index\./index\./g' ./dist/index.html
sed -i 's/\/vendor\./vendor\./g' ./dist/index.html

git add .

git commit -m "deploy script"

git subtree push --prefix dist origin gh-pages