#!/usr/bin/env bash
set -euo pipefail
bad=0
if find . -type f \( -name '*.blend' -o -name '*.png' -o -name '*.pyc' -o -name '*.log' -o -name '*.pem' -o -name '*.key' \) | grep -Ev '^\./(target|\.git)/' | grep -q .; then
  echo "release contains forbidden binary/local artifacts" >&2
  find . -type f \( -name '*.blend' -o -name '*.png' -o -name '*.pyc' -o -name '*.log' -o -name '*.pem' -o -name '*.key' \) | grep -Ev '^\./(target|\.git)/' >&2
  bad=1
fi
python3 - <<'PY' || bad=1
from pathlib import Path
import re, sys
pat = re.compile(r'(api[_-]?key|secret|token|password|passwd|PRIVATE KEY|BEGIN OPENSSH|AKIA|sk-[A-Za-z0-9]|ghp_|github_pat_|netlify|cloudflare|stripe)', re.I)
skip_dirs = {'.git','target','dist','__pycache__'}
skip_files = {'scripts/check-release-clean.sh','Cargo.lock'}
hits=[]
for path in Path('.').rglob('*'):
    if not path.is_file():
        continue
    rel=path.as_posix().lstrip('./')
    if rel in skip_files or any(part in skip_dirs for part in path.parts):
        continue
    try:
        text=path.read_text(errors='ignore')
    except Exception:
        continue
    for i,line in enumerate(text.splitlines(),1):
        if pat.search(line):
            hits.append(f"{rel}:{i}:{line[:180]}")
if hits:
    print('possible sensitive string found:', file=sys.stderr)
    print('\n'.join(hits), file=sys.stderr)
    sys.exit(1)
PY
exit "$bad"
