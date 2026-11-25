#!/usr/bin/env bash
set -euo pipefail

site=$1
repo=robit-man/cloudflared-quick-tunnel-tray
mkdir -p "$site/downloads"
cp index.html "$site/index.html"

# Resolve Latest once so every package and checksum comes from the same release.
tag=$(gh release view --repo "$repo" --json tagName --jq .tagName)
gh release download "$tag" --repo "$repo" --dir "$site/downloads" --clobber \
    --pattern 'quick-tunnel-tray-*' --pattern SHA256SUMS
(cd "$site/downloads" && sha256sum --strict -c SHA256SUMS)

python3 - "$site" "$repo" <<'PY'
import re
import sys
from pathlib import Path

site = Path(sys.argv[1])
page = site / "index.html"
prefix = f"https://github.com/{sys.argv[2]}/releases/latest/download/"
html = page.read_text(encoding="utf-8")
assets = set(re.findall(re.escape(prefix) + r'(quick-tunnel-tray-[a-z0-9.-]+)"', html))
checksums = (site / "downloads/SHA256SUMS").read_text(encoding="utf-8").splitlines()
verified = {line[66:] for line in checksums}
if len(assets) != 5 or not assets <= verified:
    raise SystemExit("The release is missing one or more installers linked from TTY")
if any(not (site / "downloads" / asset).is_file() for asset in assets):
    raise SystemExit("One or more verified installers are missing from the site")
page.write_text(html.replace(prefix, "downloads/"), encoding="utf-8")
PY
