# stac-check-action

[![CI](https://github.com/lowlydba/stac-check-action/actions/workflows/ci.yml/badge.svg)](https://github.com/lowlydba/stac-check-action/actions/workflows/ci.yml) [![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/lowlydba/stac-check-action/ci.yml)](https://github.com/lowlydba/stac-check-action/actions/workflows/ci.yml) [![immutable release ruleset](https://img.shields.io/badge/immutable%20tags-active-green?logo=github)](https://github.com/lowlydba/stac-check-action/rules) [![stac-check-action](https://img.shields.io/badge/stac--check--action-🎯-blue?style=flat)](https://github.com/lowlydba/stac-check-action)

A lightweight composite GitHub Action that runs [`stac-check`](https://github.com/stac-utils/stac-check) against local STAC files — validates, lints, and checks best practices for STAC items, collections, and catalogs.

- 🔒 dependency-free (composite, no external actions)
- ⚛️ small size (runner-native tools only)
- 💰 saves CI minutes (fast validation modes)
- 🌎 local-only (no network access required)
- 🎯 pairs seamlessly with [`actions/checkout`](https://github.com/actions/checkout)

---

- [Usage](#usage)
- [Inputs](#inputs)
- [Example: PR Comment](#example-pr-comment)
- [Example: Inline Config](#example-inline-config)
- [Show Your Support](#show-your-support)

## Usage

Add this step after checking out your repository:

```yaml
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
      - uses: lowlydba/stac-check-action@a1b2c3d4e5f6789012345678901234567890abcd # v1.0.0
        with:
          stac-check-version: v1.14.0
          file: ./stac/item.json
```

For PR comments with fast validation:

```yaml
jobs:
  validate:
    runs-on: ubuntu-latest
    permissions:
      pull-requests: write
    steps:
      - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
      - uses: lowlydba/stac-check-action@a1b2c3d4e5f6789012345678901234567890abcd # v1.0.0
        with:
          stac-check-version: v1.14.0
          file: ./stac/collection.json
          fast-linting: true
          comment-pr: true
          validate-assets: true
```

Tip

SemVer tags (e.g. `v1.0.0`) and major tags (e.g. `v1`) are immutable, enforced via [repository rulesets](https://github.com/lowlydba/stac-check-action/rules). For maximum supply chain security, [pin to a full commit SHA](https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions#using-third-party-actions) rather than a tag.

## Inputs

Input

Description

Allowed Values

Default

`stac-check-version` **(required)**

Exact version (e.g. `v1.14.0`) or `latest` for newest release

`string`

—

`file` **(required)**

Path to local STAC file to validate

`string`

—

`recursive`

Recursively validate related local STAC objects

`'true'` or `'false'`

`'false'`

`max-depth`

Maximum recursion depth (requires `recursive: true`)

`integer`

—

`validate-assets`

Validate assets locally (no network requests)

`'true'` or `'false'`

`'false'`

`pydantic`

Use stac-pydantic for enhanced validation

`'true'` or `'false'`

`'false'`

`verbose`

Show verbose error messages

`'true'` or `'false'`

`'false'`

`fast`

Fast validation with FastJSONSchema, no geometry/linting

`'true'` or `'false'`

`'false'`

`fast-linting`

Fast validation with linting, no geometry checks

`'true'` or `'false'`

`'false'`

`output-file`

Save CLI output to file (separate from job summary)

`string`

—

`config`

Path to config file or inline YAML (sets `STAC_CHECK_CONFIG`)

`string`

—

`job-summary`

Write results to GitHub job summary

`'true'` or `'false'`

`'true'`

`comment-pr`

Post results as PR comment (requires `pull-requests: write`)

`'true'` or `'false'`

`'false'`

`extra-args`

Additional CLI arguments (appended last)

`string`

—

## Outputs

Name

Description

`exit-code`

Exit code from stac-check (0=valid, non-zero=issues)

## Example: PR Comment

```yaml
      - uses: lowlydba/stac-check-action@a1b2c3d4e5f6789012345678901234567890abcd # v1.0.0
        with:
          stac-check-version: v1.14.0
          file: ./stac/collection.json
          fast-linting: true
          comment-pr: true
          config: .github/stac-check-config.yml
```

## Example: Inline Config

```yaml
      - uses: lowlydba/stac-check-action@a1b2c3d4e5f6789012345678901234567890abcd # v1.0.0
        with:
          stac-check-version: v1.14.0
          file: ./item.json
          config: |
            linting:
              check_geometry: false
              bloated_links: true
            settings:
              max_links: 10
```

## Requirements

- Runner with Python 3.10+ and pip pre-installed
- `stac-check` version must exist on PyPI and support Python 3.10+

## Security

- No external action dependencies
- Minimal permissions (only `pull-requests: write` if using `comment-pr`)
- No network access required (local files only)
- Users specify exact versions (use `latest` only for non-critical workflows)

## Show Your Support

Add a badge to your repository:

[![stac-check-action](https://img.shields.io/badge/stac--check--action-🎯-blue?style=flat)](https://github.com/lowlydba/stac-check-action)

```markdown
[![stac-check-action](https://img.shields.io/badge/stac--check--action-🎯-blue?style=flat)](https://github.com/lowlydba/stac-check-action)
```

## Full Specification

See [SPEC.md](./SPEC.md) for complete technical details.

## About

🎯 GitHub Action that runs stac-check for local STAC file validation, linting, and best practices compliance.

[github.com/marketplace/actions/stac-check-action](https://github.com/marketplace/actions/stac-check-action)

## License

[MIT](./LICENSE)
