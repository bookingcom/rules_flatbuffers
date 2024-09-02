#!/usr/bin/env bash

set -eou pipefail

if [ -z "${FLATC_BINARY:-}" ]; then
    echo "Please set FLATC_BINARY to the path of the flatc binary." > /dev/stderr
    exit 1
fi

exec $FLATC_BINARY "$@"
