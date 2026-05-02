# Contributing

Thanks for considering a contribution.

## Ground Rules

- Read [SPEC.md](./SPEC.md) before proposing changes — design principles are intentional (composite-only, zero external action deps, local-only by default).
- Discuss substantial changes in an issue before opening a PR.
- All PRs must pass CI (matrix tests, lint, zizmor, actionlint, e2e).
- Follow existing code style (LF line endings, 2-space YAML indent).

## Local Setup

```bash
git clone https://github.com/lowlydba/stac-check-action.git
cd stac-check-action
pip install stac-check==1.9.1   # or pin to whatever you're testing against
```

## Testing Locally

Validate `action.yml` parses:

```bash
python -c "import yaml; yaml.safe_load(open('action.yml'))"
```

Run the action's logic against a local STAC file:

```bash
stac-check ./path/to/item.json
```

Run zizmor (requires [installation](https://docs.zizmor.sh/installation/)):

```bash
GITHUB_TOKEN=$(gh auth token) zizmor .
```

Run actionlint:

```bash
actionlint
```

## Pull Request Checklist

- [ ] Branch from `main`
- [ ] One logical change per PR
- [ ] CHANGELOG.md updated under `[Unreleased]`
- [ ] SPEC.md updated if behavior changes
- [ ] README.md updated if user-facing
- [ ] CI green (zizmor + actionlint + matrix tests + e2e)
- [ ] Commits follow [Conventional Commits](https://www.conventionalcommits.org/) format

## Commit Message Format

```
type(scope): short description

Longer body if needed.
```

Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`, `perf`.

## Releasing

Maintainers only. See [SPEC.md § Release Process](./SPEC.md#release-process).

## Code of Conduct

This project adheres to the [Contributor Covenant](./CODE_OF_CONDUCT.md). By participating, you agree to its terms.
