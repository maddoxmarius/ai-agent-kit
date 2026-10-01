#!/usr/bin/env bash
set -e

CONTEXT="${1:-private}"
MODE="${2:-all}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KIT="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT="$(pwd)"

if [[ "$CONTEXT" != "private" && "$CONTEXT" != "dedalus" ]] ||
   [[ "$MODE" != "all" && "$MODE" != "--skills-only" ]] || [[ $# -gt 2 ]]; then
  echo "Usage: $0 [private|dedalus] [--skills-only]"
  echo "  default: private; --skills-only preserves existing instructions"
  exit 1
fi

RULES_SRC="$KIT/rules/$CONTEXT"
SKILLS_SRC="$KIT/skills"
GITHUB_DST="$PROJECT_ROOT/.github"
INSTRUCTIONS_DST="$GITHUB_DST/instructions"
MAIN_DST="$GITHUB_DST/copilot-instructions.md"
SKILLS_DST="$GITHUB_DST/skills"

if [[ "$MODE" == "all" && ! -d "$RULES_SRC" ]]; then
  echo "Error: rules not found at $RULES_SRC (kit at $KIT)"
  exit 1
fi

if [[ ! -d "$SKILLS_SRC" ]]; then
  echo "Error: skills not found at $SKILLS_SRC (kit at $KIT)"
  exit 1
fi

if [[ "$MODE" == "all" ]]; then
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
    if [[ "$base" == _main || "$base" == *.instructions ]]; then
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
fi

mkdir -p "$SKILLS_DST"
for skill in "$SKILLS_SRC"/*; do
  [[ -d "$skill" && -f "$skill/SKILL.md" ]] || continue
  name=$(basename "$skill")
  mkdir -p "$SKILLS_DST/$name"
  cp -R "$skill/." "$SKILLS_DST/$name/"
  echo "  installed skill: .github/skills/$name"
done

echo "Copilot ($CONTEXT) installed to .github/"
echo "Verify: ls -la .github/ .github/instructions/ .github/skills/"
