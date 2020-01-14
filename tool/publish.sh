#!/usr/bin/env bash
cd `dirname $0`/..

export PUB_HOSTED_URL=https://pub.dev
# export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# dartfmt -w lib -l 80
pub publish "$@"
