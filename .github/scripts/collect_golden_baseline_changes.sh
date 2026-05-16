#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 3 ]; then
  echo "usage: collect_golden_baseline_changes.sh <base-sha> <head-sha> <output-tsv>" >&2
  exit 2
fi

base_sha="$1"
head_sha="$2"
output_tsv="$3"

mkdir -p "$(dirname "$output_tsv")"
: > "$output_tsv"

git diff --name-status --find-renames "$base_sha" "$head_sha" -- ':(glob)test/**/goldens/**/*.png' |
  while IFS=$'\t' read -r status first_path second_path; do
    case "$status" in
      A)
        printf 'added\t%s\t\n' "$first_path"
        ;;
      D)
        printf 'removed\t%s\t\n' "$first_path"
        ;;
      M|T)
        printf 'modified\t%s\t\n' "$first_path"
        ;;
      R*)
        printf 'renamed\t%s\t%s\n' "$second_path" "$first_path"
        ;;
      C*)
        printf 'added\t%s\t\n' "$second_path"
        ;;
    esac
  done >> "$output_tsv"
