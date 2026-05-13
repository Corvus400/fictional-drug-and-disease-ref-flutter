# fictional-drug-and-disease-ref-flutter

A reference Flutter application that consumes the
[fictional-drug-and-disease-ref mock-server](https://github.com/Corvus400/fictional-drug-and-disease-ref-mock-server).

This is a portfolio repository. External pull requests are not accepted.
Issues remain enabled for the Renovate Dependency Dashboard and limited
security/process notices.

All drug, disease, and clinical content in this project is fictional. It is
not medical advice and must not be used for diagnosis, treatment, prescribing,
or any other medical decision.

## Repository Operations

- Dependency update pull requests are managed by Renovate.
- External pull requests are rejected by CI and are not reviewed.
- General support, feature requests, and bug reports are not accepted through
  GitHub Issues.
- Security reports must follow [SECURITY.md](./SECURITY.md).

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
