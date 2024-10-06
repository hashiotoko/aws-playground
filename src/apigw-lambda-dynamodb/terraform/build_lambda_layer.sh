#!/bin/bash

set -e

rm -rf dist/lambda_layer/nodejs
mkdir -p dist/lambda_layer/nodejs
cp package.json yarn.lock dist/lambda_layer/nodejs/

pushd dist/lambda_layer/nodejs
yarn install --production
popd
