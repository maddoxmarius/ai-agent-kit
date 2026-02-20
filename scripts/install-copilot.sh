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
MAIN_DST="$GITHUB_DST/copilot-instructions.md"

if [[ ! -d "$RULES_SRC" ]]; then
  echo "Error: rules not found at $RULES_SRC (kit at $KIT)"
  exit 1
fi

mkdir -p "$INSTRUCTIONS_DST"

strip_frontmatter() {
  if [[ -r "$1" ]]; then
    awk '/^---$/{ if (++n == 2) next } n < 2 { next } 1' "$1"
  fi
}

if [[ -f "$RULES_SRC/_main.md" ]]; then
  cp "$RULES_SRC/_main.md" "$MAIN_DST"
  echo "  installed: .github/copilot-instructions.md (from _main.md)"
fi

for f in "$RULES_SRC"/*.md; do
  [[ -e "$f" ]] || continue
  base=$(basename "$f" .md)
  if [[ "$base" == _main ]]; then
    continue
  fi
  if [[ "$base" == *.instructions ]]; then
    continue
  fi
  {
    echo ""
    echo "---"
    echo ""
    strip_frontmatter "$f"
  } >> "$MAIN_DST"
  echo "  appended to copilot-instructions.md: $base.md"
done

for f in "$RULES_SRC"/*.instructions.md; do
  [[ -e "$f" ]] || continue
  name=$(basename "$f")
  cp "$f" "$INSTRUCTIONS_DST/$name"
  echo "  installed: .github/instructions/$name"
done

echo "Copilot instructions ($CONTEXT) installed to .github/"
echo "Verify: ls -la .github/ .github/instructions/"
