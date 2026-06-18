#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$ROOT/dist/addon"
cp "$ROOT/addon/last_airblender.py" "$ROOT/dist/addon/last_airblender.py"
(cd "$ROOT/dist/addon" && zip -q -r "$ROOT/dist/last-airblender-addon.zip" last_airblender.py)
rm -rf "$ROOT/dist/addon"
echo "$ROOT/dist/last-airblender-addon.zip"
