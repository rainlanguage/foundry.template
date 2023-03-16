#!/usr/bin/env sh

mkdir -p ./.github/workflows
cp -f ./lib/qakit.foundry/.github/workflows/qakit-slither.yaml ./.github/workflows/qakit-slither.yaml
cp -f ./lib/qakit.foundry/.github/workflows/qakit-test.yaml ./.github/workflows/qakit-test.yaml