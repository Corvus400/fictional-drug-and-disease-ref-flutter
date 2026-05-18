#!/usr/bin/env bash
# Deterministic Renovate PR fact collector. Never fails hard; sets _parse_failed on uncertainty.
# shellcheck disable=SC2016
set -u -o pipefail

REPO="${1:?repo required}"
PR="${2:?pr number required}"

PR_JSON="$(gh api "repos/$REPO/pulls/$PR" 2>/dev/null || echo '{}')"
TITLE="$(jq -r '.title // ""' <<<"$PR_JSON")"
BODY="$(jq -r '.body // ""' <<<"$PR_JSON")"

if [ -z "$BODY" ]; then
  jq -n --arg pr "$PR" --arg title "$TITLE" '{
    pr_number: ($pr|tonumber), title: $title, group_name: null,
    is_vulnerability_alert: false, packages: [],
    _parse_failed: true, _raw_body: null,
    _note: "empty body or fetch failed"
  }'
  exit 0
fi

DIFF="$(gh pr diff --repo "$REPO" "$PR" 2>/dev/null || true)"

GROUP_NAME="$(printf '%s' "$TITLE" \
  | sed -E 's/^(chore|fix|feat)\(deps\):[[:space:]]*update[[:space:]]+(.*)$/\2/I' \
  | sed -E 's/[[:space:]]*\((major|minor|patch|digest)\)$//I')"

IS_VULN=false
if grep -qiE '\[SECURITY\]|vulnerability' <<<"$TITLE"; then IS_VULN=true; fi
if grep -qiE 'isVulnerabilityAlert|security advisory' <<<"$BODY"; then IS_VULN=true; fi

PARSE_FAILED=false
TABLE_LINES="$(awk '
  /^\| Package \|/ { intable=1; next }
  intable && /^\|[[:space:]]*---/ { next }
  intable && /^$/ { intable=0 }
  intable && /^\| / { print }
' <<<"$BODY")"

[ -z "$TABLE_LINES" ] && PARSE_FAILED=true

pkgs_tmp="$(mktemp)"
printf '[]' > "$pkgs_tmp"

while IFS= read -r row; do
  [ -n "$row" ] || continue

  pkg_cell="$(awk -F'|' '{print $2}' <<<"$row" | sed -E 's/^[[:space:]]+|[[:space:]]+$//g')"
  coord="$(sed -nE 's/^\[([^]]+)\].*$/\1/p' <<<"$pkg_cell")"
  [ -n "$coord" ] || coord="$(sed -E 's/^`?([^`[:space:]]+)`?.*$/\1/' <<<"$pkg_cell")"

  change_cell="$(awk -F'|' '{print $3}' <<<"$row")"
  old_v="$(sed -nE 's/.*`([^`]+)`[[:space:]]*→[[:space:]]*`([^`]+)`.*/\1/p' <<<"$change_cell")"
  new_v="$(sed -nE 's/.*`([^`]+)`[[:space:]]*→[[:space:]]*`([^`]+)`.*/\2/p' <<<"$change_cell")"

  src_cell="$(awk -F'|' '{print $(NF-1)}' <<<"$row" | sed -E 's/^[[:space:]]+|[[:space:]]+$//g')"
  src_url="$(sed -nE 's/.*\(([^)]+)\).*/\1/p' <<<"$src_cell")"
  [ "$src_url" = "—" ] && src_url=""

  notes="$(awk -v key="$coord" '
    BEGIN { in_details=0; capture=0; buf="" }
    /<details>/ { in_details=1; next }
    /<\/details>/ { if (capture) { print buf; exit } in_details=0; capture=0; buf=""; next }
    in_details && /<summary>/ { if (index($0, key) > 0) { capture=1 } next }
    capture { buf = buf $0 "\n" }
  ' <<<"$BODY")"

  cmp_url="$(grep -oE 'https://[^)]*compare[^)]*' <<<"$notes" | head -1)"
  if [ -z "$cmp_url" ] && [ -n "$old_v" ]; then
    cmp_url="$(grep -oE "https://[^)]*compare[^)]*${old_v//./\\.}[^)]*" <<<"$BODY" | head -1)"
  fi

  pkg_file=""
  if [ -n "$DIFF" ] && [ -n "$new_v" ]; then
    pkg_file="$(awk '/^diff --git /{f=$4} /^[+-][^+-].*'"${new_v//./\\.}"'/{print f; exit}' <<<"$DIFF" | sed 's|^b/||')"
  fi

  pkgs="$(jq --arg c "$coord" --arg o "$old_v" --arg n "$new_v" --arg s "$src_url" \
             --arg cu "$cmp_url" --arg pf "$pkg_file" --arg rn "$notes" '
    . + [{coordinate:$c, old_version:$o, new_version:$n,
          source_url:$s, compare_url:$cu, package_file:$pf, release_notes_raw:$rn}]
  ' "$pkgs_tmp")"
  printf '%s' "$pkgs" > "$pkgs_tmp"
done <<<"$TABLE_LINES"

PACKAGES_JSON="$(cat "$pkgs_tmp")"
rm -f "$pkgs_tmp"

jq -n --arg pr "$PR" --arg title "$TITLE" --arg group "$GROUP_NAME" \
      --argjson vuln "$IS_VULN" --argjson pkgs "$PACKAGES_JSON" \
      --argjson parse_failed "$PARSE_FAILED" --arg body "$BODY" '
{
  pr_number: ($pr|tonumber),
  title: $title,
  group_name: (if $group == "" then null else $group end),
  is_vulnerability_alert: $vuln,
  packages: $pkgs,
  _parse_failed: $parse_failed,
  _raw_body: (if $parse_failed then $body else null end)
}
'
