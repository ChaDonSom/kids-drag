#!/bin/bash

sed -i 's/\/assets/assets/g' ./dist/index.html
sed -i 's/\/favicon/favicon/g' ./dist/index.html

git add .

git commit -m "deploy script"

git subtree push --prefix dist origin gh-pages