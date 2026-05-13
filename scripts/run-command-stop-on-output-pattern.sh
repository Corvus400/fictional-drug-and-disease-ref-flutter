#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -eq 0 ]; then
  echo "usage: $0 <command> [args...]" >&2
  exit 2
fi

pattern="${CI_FAIL_OUTPUT_PATTERN:-Bad state:}"
export CI_FAIL_OUTPUT_PATTERN="$pattern"

set +e
"$@" 2>&1 | perl -ne '
  BEGIN { $pattern = $ENV{"CI_FAIL_OUTPUT_PATTERN"}; }
  print;
  if (index($_, $pattern) >= 0) {
    print STDERR "::error::Detected \"$pattern\" in command output. Stopping early.\n";
    exit 66;
  }
'
status=$?
set -e

if [ "$status" -eq 66 ]; then
  exit 1
fi

exit "$status"
