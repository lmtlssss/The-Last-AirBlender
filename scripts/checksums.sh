#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../dist"
find . -maxdepth 1 -type f ! -name checksums.txt -printf '%f\0' | sort -z | xargs -0 sha256sum > checksums.txt
cat checksums.txt
