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
RULES_DST="$PROJECT_ROOT/.cursor/rules"
SKILLS_SRC="$KIT/skills"
SKILLS_DST="$PROJECT_ROOT/.cursor/skills"

if [[ ! -d "$RULES_SRC" ]]; then
  echo "Error: rules not found at $RULES_SRC (kit at $KIT)"
  exit 1
fi

mkdir -p "$RULES_DST"
rm -f "$RULES_DST"/*.mdc 2>/dev/null || true

for f in "$RULES_SRC"/*.md; do
  [[ -e "$f" ]] || continue
  base=$(basename "$f" .md)
  if [[ "$base" == _main ]]; then
    continue
  fi
  if [[ "$base" == *.instructions ]]; then
    continue
  fi
  cp "$f" "$RULES_DST/${base}.mdc"
  echo "  installed rule: ${base}.mdc"
done

mkdir -p "$SKILLS_DST"
if [[ -d "$SKILLS_SRC" ]]; then
  rm -rf "$SKILLS_DST"
  cp -r "$SKILLS_SRC" "$SKILLS_DST"
  echo "  installed skills: $(ls "$SKILLS_DST" | tr '\n' ' ')"
fi

echo "Cursor rules ($CONTEXT) installed to .cursor/rules/"
echo "Verify: ls -la .cursor/rules/ .cursor/skills/"
