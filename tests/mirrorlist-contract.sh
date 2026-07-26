#!/usr/bin/env sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
REPO_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
WORKSPACE_ROOT="$(CDPATH= cd -- "$REPO_ROOT/.." && pwd)"
MIRRORLIST="$REPO_ROOT/packages/basalt-mirrorlist/basalt-mirrorlist"
HOSTING_CONTRACT="$WORKSPACE_ROOT/infra/repo-hosting/repo-hosting.json"

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  exit 1
}

[ -f "$MIRRORLIST" ] || fail "mirrorlist not found: $MIRRORLIST"
[ -f "$HOSTING_CONTRACT" ] || fail "hosting contract not found: $HOSTING_CONTRACT"
command -v jq >/dev/null 2>&1 || fail "jq is required"

base_url="$(jq -r '.repository.base_url' "$HOSTING_CONTRACT")"
stable_path="$(jq -r '.repository.channels[] | select(.name == "stable") | .path' "$HOSTING_CONTRACT")"
staging_path="$(jq -r '.repository.channels[] | select(.name == "staging") | .path' "$HOSTING_CONTRACT")"

stable_server="${base_url}${stable_path}"
staging_server="${base_url}${staging_path}"

grep -Fq "Server = $stable_server" "$MIRRORLIST" \
  || fail "stable mirror URL does not match hosting contract: $stable_server"
grep -Fq "# Server = $staging_server" "$MIRRORLIST" \
  || fail "staging mirror URL does not match hosting contract: $staging_server"
grep -Fq 'backup=(' "$REPO_ROOT/packages/basalt-mirrorlist/PKGBUILD" \
  || fail "basalt-mirrorlist PKGBUILD must mark mirrorlist as backup"

printf 'mirrorlist-contract: ok\n'
