#!/usr/bin/env bash
# Run stac-check with inputs supplied via environment variables.
# Called by action.yml; testable standalone with a mock stac-check on PATH.
#
# Required env vars (set by action.yml env: block):
#   IN_FILE, IN_RECURSIVE, IN_MAX_DEPTH, IN_VALIDATE_ASSETS, IN_PYDANTIC,
#   IN_VERBOSE, IN_FAST, IN_FAST_LINTING, IN_OUTPUT_FILE, IN_EXTRA_ARGS,
#   IN_CONFIG
#
# GitHub Actions env vars (defaulted for local/test use):
#   GITHUB_OUTPUT, RUNNER_TEMP
set -uo pipefail

: "${GITHUB_OUTPUT:=/dev/null}"
: "${RUNNER_TEMP:=$(mktemp -d)}"

ARGS=()

if [ "${IN_RECURSIVE:-false}" = "true" ]; then
  ARGS+=(--recursive)
  if [ -n "${IN_MAX_DEPTH:-}" ]; then
    ARGS+=(--max-depth "$IN_MAX_DEPTH")
  fi
fi

if [ "${IN_VALIDATE_ASSETS:-false}" = "true" ]; then
  ARGS+=(--assets --no-assets-urls)
fi

[ "${IN_PYDANTIC:-false}"      = "true" ] && ARGS+=(--pydantic)
[ "${IN_VERBOSE:-false}"       = "true" ] && ARGS+=(--verbose)

if [ "${IN_FAST:-false}" = "true" ]; then
  ARGS+=(--fast)
elif [ "${IN_FAST_LINTING:-false}" = "true" ]; then
  ARGS+=(--fast-linting)
fi

if [ -n "${IN_OUTPUT_FILE:-}" ]; then
  if [ "${IN_RECURSIVE:-false}" != "true" ]; then
    echo "::error::output-file requires recursive: true (stac-check CLI limitation)"
    exit 1
  fi
  ARGS+=(--output "$IN_OUTPUT_FILE")
  echo "output-file=$IN_OUTPUT_FILE" >> "$GITHUB_OUTPUT"
fi

# Append extra-args (word-split intentionally for CLI flags)
if [ -n "${IN_EXTRA_ARGS:-}" ]; then
  # shellcheck disable=SC2206
  EXTRA=($IN_EXTRA_ARGS)
  ARGS+=("${EXTRA[@]}")
fi

ARGS+=("${IN_FILE:?IN_FILE is required}")

# Handle config: file path OR inline YAML (multiline)
if [ -n "${IN_CONFIG:-}" ]; then
  if [ -f "$IN_CONFIG" ]; then
    export STAC_CHECK_CONFIG="$IN_CONFIG"
  elif [[ "$IN_CONFIG" == *$'\n'* ]]; then
    CONFIG_PATH="$RUNNER_TEMP/stac-check-config.yml"
    printf '%s' "$IN_CONFIG" > "$CONFIG_PATH"
    export STAC_CHECK_CONFIG="$CONFIG_PATH"
  else
    echo "::error::config input is neither a readable file path nor multiline inline YAML"
    exit 1
  fi
fi

OUTPUT_PATH="$RUNNER_TEMP/stac-check-output.txt"
echo "output-path=$OUTPUT_PATH" >> "$GITHUB_OUTPUT"

set +e
stac-check "${ARGS[@]}" > "$OUTPUT_PATH" 2>&1
EXIT_CODE=$?
set -e

cat "$OUTPUT_PATH"
echo "exit-code=$EXIT_CODE" >> "$GITHUB_OUTPUT"
