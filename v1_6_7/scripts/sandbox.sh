#!/usr/bin/env bash

set -eu

make build_sandbox
cp --remove-destination /app/src/oscar/static/oscar/img/image_not_found.jpg /app/sandbox/public/media/
#chown -R oscar. /app/sandbox
