#!/usr/bin/env bash
set -e

CONTEXT="${1:-private}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KIT="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT="$(pwd)"

if [[ "$CONTEXT" != "private" && "$CONTEXT" != "dedalus" ]]; then
  echo "Usage: $0 [private|dedalus]"
  echo "  default: private"
  exit 1
fi

RULES_SRC="$KIT/rules/$CONTEXT"
GITHUB_DST="$PROJECT_ROOT/.github"
INSTRUCTIONS_DST="$GITHUB_DST/instructions"

if [[ ! -d "$RULES_SRC" ]]; then
  echo "Error: rules not found at $RULES_SRC (kit at $KIT)"
  exit 1
fi

mkdir -p "$INSTRUCTIONS_DST"

if [[ -f "$RULES_SRC/_main.md" ]]; then
  cp "$RULES_SRC/_main.md" "$GITHUB_DST/copilot-instructions.md"
  echo "  installed: .github/copilot-instructions.md"
fi

for f in "$RULES_SRC"/*.instructions.md; do
  [[ -e "$f" ]] || continue
  name=$(basename "$f")
  cp "$f" "$INSTRUCTIONS_DST/$name"
  echo "  installed: .github/instructions/$name"
done

echo "Copilot instructions ($CONTEXT) installed to .github/"
echo "Verify: ls -la .github/ .github/instructions/"
