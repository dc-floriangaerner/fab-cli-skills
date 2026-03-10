#!/usr/bin/env bash
set -euo pipefail

TARGET_SKILLS_DIR="${1:-}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_SKILLS_DIR="${REPO_ROOT}/skills"

if [[ ! -d "${SOURCE_SKILLS_DIR}" ]]; then
  echo "Could not find source skills directory at ${SOURCE_SKILLS_DIR}" >&2
  exit 1
fi

if [[ -z "${TARGET_SKILLS_DIR}" ]]; then
  if [[ -n "${CODEX_HOME:-}" ]]; then
    TARGET_SKILLS_DIR="${CODEX_HOME}/skills"
  else
    TARGET_SKILLS_DIR="${HOME}/.codex/skills"
  fi
fi

mkdir -p "${TARGET_SKILLS_DIR}"

echo
echo "Installing Fabric CLI skills pack"
echo "Source: ${SOURCE_SKILLS_DIR}"
echo "Target: ${TARGET_SKILLS_DIR}"
echo

for skill_dir in "${SOURCE_SKILLS_DIR}"/*; do
  [[ -d "${skill_dir}" ]] || continue
  skill_name="$(basename "${skill_dir}")"
  target_dir="${TARGET_SKILLS_DIR}/${skill_name}"
  rm -rf "${target_dir}"
  cp -R "${skill_dir}" "${target_dir}"
  echo "Installed ${skill_name}"
done

echo
echo "Done."
echo "Restart Codex if it is already open, then use prompts like:"
echo '  Use $fab-bootstrap to install Fabric CLI and set up user login.'
echo '  Use $fab-discovery to inspect my Fabric workspace.'
