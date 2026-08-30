#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
env_file="$root/secrets.env"
out_dir="$root/password"

declare -A files=(
  [TANGLED_APP_PASSWORD]="tangled-app-password"
  [TELEGRAM_API_ID]="telegram-api-id"
  [TELEGRAM_API_HASH]="telegram-api-hash"
)

[ -r "$env_file" ] || { echo "secrets.env not found or unreadable: $env_file" >&2; exit 1; }

umask 077
mkdir -p "$out_dir"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

nix shell nixpkgs#sops -c sops -d --input-type dotenv "$env_file" > "$tmp/secrets.env"

while IFS='=' read -r key value; do
  case "$key" in ''|'#'*) continue ;; esac
  file="${files[$key]:-}"
  [ -n "$file" ] || continue
  printf '%s\n' "$value" > "$out_dir/$file"
  chmod 600 "$out_dir/$file"
done < "$tmp/secrets.env"

echo "decrypted into $out_dir: ${files[*]}"
