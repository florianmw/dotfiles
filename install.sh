#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

if ! command -v chezmoi >/dev/null 2>&1; then
  bin_dir="${HOME}/.local/bin"
  mkdir -p "$bin_dir"
  sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b "$bin_dir"
  export PATH="$bin_dir:$PATH"
fi

chezmoi init --apply --source "$DOTFILES_DIR"
