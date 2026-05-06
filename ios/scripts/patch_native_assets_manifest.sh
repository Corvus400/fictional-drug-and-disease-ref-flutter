#!/bin/sh
set -eu

# Flutter native assets are embedded under Runner.app/Frameworks on iOS, while
# the generated manifest may contain paths relative to Runner.app. Normalize the
# final bundled manifest after Flutter has embedded App.framework.

target_build_dir="${TARGET_BUILD_DIR:-}"
wrapper_name="${WRAPPER_NAME:-Runner.app}"

if [ -z "$target_build_dir" ]; then
  exit 0
fi

patch_manifest() {
  manifest="$1"
  if [ ! -f "$manifest" ]; then
    return 0
  fi

  ruby -e '
    path = ARGV.fetch(0)
    source = File.read(path)
    patched = source
      .gsub(%{"objective_c.framework/objective_c"}, %{"Frameworks/objective_c.framework/objective_c"})
      .gsub(%{"sqlite3.framework/sqlite3"}, %{"Frameworks/sqlite3.framework/sqlite3"})
      .gsub(%{"Frameworks/objective_c.framework/objective_c"}, %{"@executable_path/Frameworks/objective_c.framework/objective_c"})
      .gsub(%{"Frameworks/sqlite3.framework/sqlite3"}, %{"@executable_path/Frameworks/sqlite3.framework/sqlite3"})
    File.write(path, patched) if patched != source
  ' "$manifest"
}

patch_manifest "$target_build_dir/$wrapper_name/Frameworks/App.framework/flutter_assets/NativeAssetsManifest.json"
