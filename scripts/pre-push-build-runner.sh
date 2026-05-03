#!/usr/bin/env bash
set -euo pipefail

dart run build_runner build --delete-conflicting-outputs
