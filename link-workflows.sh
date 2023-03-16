#!/usr/bin/env sh

dir=".github/workflows/qakit.foundry"
mkdir -p "$dir"
rm "$dir"
ln -sr ./lib/qakit.foundry/.github/workflows "../../../../$dir"