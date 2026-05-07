# fictional-drug-and-disease-ref-flutter

A reference Flutter application that consumes the
[fictional-drug-and-disease-ref mock-server](https://github.com/Corvus400/fictional-drug-and-disease-ref-mock-server).

## License

This project is licensed under the [MIT License](./LICENSE).

### Third-Party Software

This repository bundles or references the following third-party works.
Licenses are reproduced under `third_party/` and `assets/fonts/`.

| Project | License | Usage |
|---|---|---|
| [Roborazzi](https://github.com/takahirom/roborazzi) | Apache-2.0 | Specification reference for golden test output (`*_compare.png`, `*_actual.png`, JSON schema). Dart implementation under `test/golden/_comparator/` is a clean-room reimplementation. See `third_party/roborazzi/`. |
| [Noto Sans JP](https://fonts.google.com/noto/specimen/Noto+Sans+JP) | SIL OFL 1.1 | Bundled font under `assets/fonts/`. Reserved Font Name: "Noto". |
| [Materialize CSS](https://github.com/Dogfalo/materialize) | MIT | Loaded via CDN by the local golden test report (`build/reports/golden/index.html`). Not redistributed. |
| [DroidKaigi/conference-app-2025](https://github.com/DroidKaigi/conference-app-2025) | Apache-2.0 | Workflow design reference (output naming and directory layout for forward CI compatibility). No source borrowed. |
