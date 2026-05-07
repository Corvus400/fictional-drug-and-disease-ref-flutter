# Licenses

This project itself is licensed under the [MIT License](../LICENSE).

## Bundled Third-Party Licenses

| Project | SPDX | License File | Usage Scope |
|---|---|---|---|
| Roborazzi | Apache-2.0 | `third_party/roborazzi/LICENSE.txt` | Specification reference only (clean-room Dart impl) |
| Noto Sans JP | OFL-1.1 | `assets/fonts/OFL.txt` | TTF font asset bundled in app |
| Materialize CSS | MIT | (CDN, not redistributed) | HTML report styling |
| Flutter SDK | BSD-3-Clause | (transitive) | Framework |
| alchemist | MIT | (in `pubspec.lock` deps tree) | Test runner support |
| image | Apache-2.0 | (in `pubspec.lock` deps tree) | PNG manipulation in golden comparator |

## License Compatibility

- MIT (this project) is permissive and compatible with all third-party licenses listed above.
- Apache-2.0 NOTICE inclusion (`third_party/roborazzi/NOTICE.txt`) is courtesy attribution; no Roborazzi source code is included.
- OFL-1.1 (Noto Sans JP) restricts the Reserved Font Name "Noto" from being applied to modified versions. This project does not modify the font.
