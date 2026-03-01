#!/usr/bin/env bash
set -e

# Install AI Agent Kit rules and skills into the kit repo itself.
# This script is meant to be run from *inside* the ai-agent-kit repository,
# configuring it as a first-class Cursor/VSCode project.

CONTEXT="${1:-private}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KIT="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT="$KIT"

if [[ "$CONTEXT" != "private" && "$CONTEXT" != "dedalus" ]]; then
  echo "Usage: $0 [private|dedalus]"
  echo "  default: private"
  exit 1
fi

cd "$PROJECT_ROOT"

echo "Installing Cursor rules and skills into $PROJECT_ROOT/.cursor (context: $CONTEXT)..."
"$SCRIPT_DIR/install-cursor.sh" "$CONTEXT"

echo "Installing Copilot instructions into $PROJECT_ROOT/.github (context: $CONTEXT)..."
"$SCRIPT_DIR/install-copilot.sh" "$CONTEXT"

echo "AI Agent Kit installed into this repo:"
echo "  - Cursor rules:   $PROJECT_ROOT/.cursor/rules/"
echo "  - Cursor skills:  $PROJECT_ROOT/.cursor/skills/"
echo "  - Copilot config: $PROJECT_ROOT/.github/"

