# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - TBD

### Added
- Initial release of `stac-check-action`.
- Composite GitHub Action wrapping [`stac-check`](https://github.com/stac-utils/stac-check).
- Inputs: `stac-check-version`, `file`, `recursive`, `max-depth`, `validate-assets`,
  `pydantic`, `verbose`, `fast`, `fast-linting`, `output-file`, `config`, `extra-args`,
  `job-summary`, `comment-pr`.
- Outputs: `exit-code`, `output-file`.
- Glob expansion for `file` input (e.g., `stac/**/*.json`).
- Sticky PR comment via hidden HTML marker (updates instead of stacking).
- Job summary with fenced "Validation Summary" section.
- Local-only validation by default (no network); `--no-assets-urls` enforced when
  `validate-assets: true`.
- pip cache via `actions/setup-python` integration in CI.
- Hardened workflows: `permissions: {}` top-level, per-job scoping, SHA-pinned actions,
  zizmor + actionlint in CI, dependabot for github-actions ecosystem.

[Unreleased]: https://github.com/lowlydba/stac-check-action/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/lowlydba/stac-check-action/releases/tag/v1.0.0
