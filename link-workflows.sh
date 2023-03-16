#!/usr/bin/env sh

mkdir -p .github/workflows/qakit.foundry
rm ./lib/qakit.foundry/.github/workflows
ln -s ./lib/qakit.foundry/.github/workflows .github/workflows/qakit.foundry .