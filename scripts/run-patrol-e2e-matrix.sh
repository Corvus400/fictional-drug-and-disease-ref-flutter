#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MOCK_SERVER_DIR="${MOCK_SERVER_DIR:-../fictional-drug-and-disease-ref-mock-server}"
MOCK_SERVER_URL="${MOCK_SERVER_URL:-http://localhost:8080}"
ANDROID_AVD="${FDDR_E2E_ANDROID_AVD:-Pixel_9_Pro_XL}"
ANDROID_DEVICE="${FDDR_E2E_ANDROID_DEVICE:-}"
ANDROID_LANDSCAPE_ROTATION="${FDDR_E2E_ANDROID_LANDSCAPE_ROTATION:-3}"
IPHONE_DEVICE="${FDDR_E2E_IPHONE_DEVICE:-iPhone 17}"
IPAD_DEVICE="${FDDR_E2E_IPAD_DEVICE:-iPad Pro 11-inch (M5)}"
TARGET="${FDDR_E2E_TARGET:-all}"
TEST_TARGET="${FDDR_E2E_TEST_TARGET:-patrol_test/}"
ORIENTATIONS="${FDDR_E2E_ORIENTATIONS:-portrait landscape}"
PATROL_BIN="${PATROL_BIN:-patrol}"
PATROL_TEST_SERVER_PORT="${FDDR_E2E_PATROL_TEST_SERVER_PORT:-18081}"
PATROL_APP_SERVER_PORT="${FDDR_E2E_PATROL_APP_SERVER_PORT:-18082}"
ROTATE_IOS_SIMULATOR="${FDDR_E2E_ROTATE_IOS_SIMULATOR:-1}"

SERVER_STARTED=0

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Required command is missing: $1" >&2
    exit 127
  fi
}

resolve_patrol_bin() {
  if command -v "$PATROL_BIN" >/dev/null 2>&1; then
    return
  fi

  if [[ -x "$HOME/.pub-cache/bin/patrol" ]]; then
    PATROL_BIN="$HOME/.pub-cache/bin/patrol"
    return
  fi

  echo "Required command is missing: patrol" >&2
  echo "Run: flutter pub global activate patrol_cli 4.4.0" >&2
  exit 127
}

healthcheck() {
  curl -sSf "$MOCK_SERVER_URL/health" >/dev/null
}

start_mock_server_if_needed() {
  if healthcheck; then
    echo "mock-server is already healthy: $MOCK_SERVER_URL"
    return
  fi

  if [[ ! -x "$MOCK_SERVER_DIR/scripts/start.sh" ]]; then
    echo "mock-server is not healthy and start script was not found:" >&2
    echo "  $MOCK_SERVER_DIR/scripts/start.sh" >&2
    exit 1
  fi

  echo "Starting mock-server from $MOCK_SERVER_DIR"
  (cd "$MOCK_SERVER_DIR" && ./scripts/start.sh)
  SERVER_STARTED=1

  for _ in {1..30}; do
    if healthcheck; then
      echo "mock-server became healthy: $MOCK_SERVER_URL"
      return
    fi
    sleep 1
  done

  echo "mock-server did not become healthy: $MOCK_SERVER_URL" >&2
  exit 1
}

cleanup() {
  if [[ "$SERVER_STARTED" == "1" && "${FDDR_E2E_STOP_SERVER:-0}" == "1" ]]; then
    (cd "$MOCK_SERVER_DIR" && ./scripts/stop.sh)
  fi

  if command -v adb >/dev/null 2>&1 && [[ -n "${ANDROID_DEVICE:-}" ]]; then
    adb -s "$ANDROID_DEVICE" shell cmd window user-rotation free >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

boot_android_if_needed() {
  require_command adb

  if [[ -z "$ANDROID_DEVICE" ]]; then
    ANDROID_DEVICE="$(adb devices | awk 'NR > 1 && $2 == "device" {print $1; exit}')"
  fi

  if [[ -n "$ANDROID_DEVICE" ]]; then
    echo "Using Android device: $ANDROID_DEVICE"
    return
  fi

  echo "Starting Android emulator: $ANDROID_AVD"
  if command -v android >/dev/null 2>&1; then
    android emulator start "$ANDROID_AVD" >/tmp/fddr-patrol-android-emulator.log 2>&1 &
  else
    require_command emulator
    emulator -avd "$ANDROID_AVD" >/tmp/fddr-patrol-android-emulator.log 2>&1 &
  fi

  adb wait-for-device
  ANDROID_DEVICE="$(adb devices | awk 'NR > 1 && $2 == "device" {print $1; exit}')"
  if [[ -z "$ANDROID_DEVICE" ]]; then
    echo "Android emulator did not expose an adb device." >&2
    exit 1
  fi
  echo "Using Android device: $ANDROID_DEVICE"
}

android_orientation_rotation() {
  case "$1" in
    portrait) echo "0" ;;
    landscape) echo "$ANDROID_LANDSCAPE_ROTATION" ;;
    *)
      echo "Unknown orientation: $1" >&2
      exit 2
      ;;
  esac
}

run_patrol() {
  local device="$1"
  local orientation="$2"
  shift 2

  echo "Running Patrol: device=$device orientation=$orientation target=$TEST_TARGET"
  FDDR_E2E_ORIENTATION="$orientation" "$PATROL_BIN" test \
    -t "$TEST_TARGET" \
    --flavor dev \
    --device "$device" \
    --test-server-port "$PATROL_TEST_SERVER_PORT" \
    --app-server-port "$PATROL_APP_SERVER_PORT" \
    --dart-define "API_BASE_URL=$MOCK_SERVER_URL" \
    --dart-define "FDDR_E2E_ORIENTATION=$orientation" \
    "$@"
}

run_android_matrix() {
  boot_android_if_needed
  adb -s "$ANDROID_DEVICE" reverse tcp:8080 tcp:8080

  for orientation in $ORIENTATIONS; do
    adb -s "$ANDROID_DEVICE" shell cmd window user-rotation \
      lock "$(android_orientation_rotation "$orientation")"
    run_patrol "$ANDROID_DEVICE" "$orientation"
  done
}

simulator_udid_by_name() {
  local name="$1"
  xcrun simctl list devices available |
    grep -F "$name (" |
    sed -E 's/.*\(([0-9A-Fa-f-]{36})\).*/\1/' |
    head -n 1
}

boot_simulator_if_needed() {
  local name="$1"
  local udid
  udid="$(simulator_udid_by_name "$name")"
  if [[ -z "$udid" ]]; then
    echo "iOS Simulator not found: $name" >&2
    exit 1
  fi

  if ! xcrun simctl list devices booted | grep -q "$udid"; then
    echo "Booting iOS Simulator: $name" >&2
    xcrun simctl boot "$udid"
  fi
  xcrun simctl bootstatus "$udid" -b >&2
  echo "$udid"
}

rotate_simulator_right() {
  osascript \
    -e 'tell application "Simulator" to activate' \
    -e 'tell application "System Events" to tell process "Simulator" to click menu item "Rotate Right" of menu "Device" of menu bar 1' \
    >/dev/null
}

prepare_ipad_simulator_orientation() {
  local udid="$1"
  local name="$2"
  local orientation="$3"

  echo "Restarting iPad Simulator before $orientation matrix: $name" >&2
  xcrun simctl shutdown "$udid" >/dev/null 2>&1 || true
  xcrun simctl boot "$udid"
  xcrun simctl bootstatus "$udid" -b >&2

  if [[ "$orientation" == "landscape" && "$ROTATE_IOS_SIMULATOR" == "1" ]]; then
    rotate_simulator_right
    sleep 1
  fi
}

run_ios_matrix() {
  local label="$1"
  local name="$2"
  local udid
  udid="$(boot_simulator_if_needed "$name")"

  for orientation in $ORIENTATIONS; do
    echo "Running $label simulator scenario: $name"
    if [[ "$label" == "ipad" ]]; then
      prepare_ipad_simulator_orientation "$udid" "$name" "$orientation"
    fi
    run_patrol "$udid" "$orientation"
  done
}

main() {
  require_command curl
  require_command flutter
  resolve_patrol_bin
  start_mock_server_if_needed

  cd "$ROOT_DIR"

  case "$TARGET" in
    all)
      run_android_matrix
      run_ios_matrix iphone "$IPHONE_DEVICE"
      run_ios_matrix ipad "$IPAD_DEVICE"
      ;;
    android) run_android_matrix ;;
    iphone) run_ios_matrix iphone "$IPHONE_DEVICE" ;;
    ipad) run_ios_matrix ipad "$IPAD_DEVICE" ;;
    *)
      echo "Unknown FDDR_E2E_TARGET: $TARGET" >&2
      echo "Use one of: all, android, iphone, ipad" >&2
      exit 2
      ;;
  esac
}

main "$@"
