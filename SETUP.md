# Setup Guide

Integrate the AI Agent Kit into your project using the install scripts. All rules live in **rules/**; scripts copy them into the right places for Cursor and for VSCode (GitHub Copilot).

## Prerequisites

- Git
- Project is a git repository
- Kit added as submodule at `.ai-agent-kit` (or path you pass to scripts)

## Choosing a Rule Set

- **private** – Personal/open-source projects
- **dedalus** – Dedalus projects using CFW

See [CONTEXTS.md](CONTEXTS.md) for details.

## Install with Scripts (recommended)

Run from your **project root** (where you want `.cursor/` and `.github/` to appear).

### 1. Add the submodule

```bash
git submodule add git@github.com:maddoxmarius/ai-agent-kit.git .ai-agent-kit
```

### 2. Cursor

```bash
# Private projects
.ai-agent-kit/scripts/install-cursor.sh private

# Dedalus projects
.ai-agent-kit/scripts/install-cursor.sh dedalus
```

This creates/updates:
- `.cursor/rules/*.mdc` from `rules/<context>/*.md`
- `.cursor/skills/` from `skills/`

### 3. VSCode / GitHub Copilot

```bash
# Private projects
.ai-agent-kit/scripts/install-copilot.sh private

# Dedalus projects
.ai-agent-kit/scripts/install-copilot.sh dedalus
```

This creates/updates:
- `.github/copilot-instructions.md` from `rules/<context>/_main.md`
- `.github/instructions/*.instructions.md` from `rules/<context>/*.instructions.md`

### 4. Commit

```bash
git add .gitmodules .ai-agent-kit .cursor .github
git commit -m "Add AI Agent Kit (scripts install)"
```

## Script behavior

- **Idempotent**: Safe to run again; overwrites existing installed files.
- **Kit path**: Scripts infer the kit path from their own location (e.g. when you run `.ai-agent-kit/scripts/install-cursor.sh`, the kit is `.ai-agent-kit`).
- **Context**: First argument is `private` or `dedalus` (default: `private`).

## Manual install (optional)

If you prefer not to use scripts:

1. Copy `rules/<context>/*.md` into your project as `.cursor/rules/*.mdc` (exclude `_main.md` and `*.instructions.md`).
2. Copy `skills/` to `.cursor/skills/`.
3. Copy `rules/<context>/_main.md` to `.github/copilot-instructions.md`.
4. Copy `rules/<context>/*.instructions.md` to `.github/instructions/` (keep the same filenames).

## Updating the kit

```bash
git submodule update --remote .ai-agent-kit
.ai-agent-kit/scripts/install-cursor.sh private   # or dedalus
.ai-agent-kit/scripts/install-copilot.sh private  # or dedalus
git add .ai-agent-kit .cursor .github
git commit -m "Update AI Agent Kit"
```

## Troubleshooting

### Script not found
- Run from project root.
- Use path to script: `.ai-agent-kit/scripts/install-cursor.sh` (or full path).

### "rules not found"
- Submodule not added or not at expected path. Run `git submodule add ...` first, or run the script from the repo that contains `.ai-agent-kit`.

### Cursor not seeing rules
- Confirm: `ls .cursor/rules/*.mdc` and `.cursor/skills/`.
- Restart Cursor.

### Copilot not applying instructions
- Confirm: `ls .github/copilot-instructions.md .github/instructions/`.
- Restart VS Code / refresh GitHub.

### Wrong context (private vs dedalus)
- Re-run the script with the correct context: `install-cursor.sh dedalus` or `install-copilot.sh private`, etc.

## Switching context

Re-run both scripts with the new context:

```bash
.ai-agent-kit/scripts/install-cursor.sh dedalus
.ai-agent-kit/scripts/install-copilot.sh dedalus
git add .cursor .github
git commit -m "Switch to Dedalus rule set"
```
