#!/usr/bin/env sh

mkdir -p ./.github/workflows
for f in docs slither test
do
  cp -f "./lib/qakit.foundry/.github/workflows/qakit-$f.yaml" "./.github/workflows/qakit-$f.yaml"
done
