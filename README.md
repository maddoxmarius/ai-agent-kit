# AI Agent Kit

A reusable git submodule containing AI agent rules and skills. One IDE-agnostic **rules** folder holds all content; install scripts deploy to **Cursor** and **VSCode (GitHub Copilot)**.

## Rule Sets

- **Private**: Universal rules for personal/open-source projects
- **Dedalus**: CFW (U Client Framework) design system rules for Dedalus work

See [CONTEXTS.md](CONTEXTS.md) for when to use which set.

## Layout

- **rules/** – Single source of truth (no IDE-specific paths)
  - **rules/private/** – Private rule set
  - **rules/dedalus/** – Dedalus rule set
- **skills/** – Cursor skills (code review, commit messages, error handling, testing)
- **scripts/** – Install scripts for each IDE

## Quick Start

From your project root (with the kit added as submodule at `.ai-agent-kit`):

```bash
# Add the submodule
git submodule add git@github.com:maddoxmarius/ai-agent-kit.git .ai-agent-kit

# Cursor: install rules + skills (private or dedalus)
.ai-agent-kit/scripts/install-cursor.sh private

# VSCode / GitHub Copilot: install instructions
.ai-agent-kit/scripts/install-copilot.sh private
```

For Dedalus projects use `dedalus` instead of `private`:

```bash
.ai-agent-kit/scripts/install-cursor.sh dedalus
.ai-agent-kit/scripts/install-copilot.sh dedalus
```

## What Gets Installed

**Cursor** (install-cursor.sh): copies rules to `.cursor/rules/*.mdc` and skills to `.cursor/skills/`

**VSCode / Copilot** (install-copilot.sh): copies `_main.md` to `.github/copilot-instructions.md` and `*.instructions.md` to `.github/instructions/`

## Verification

- **Cursor**: `ls .cursor/rules/ .cursor/skills/`
- **Copilot**: `ls .github/copilot-instructions.md .github/instructions/`

## Detailed Setup

See [SETUP.md](SETUP.md) for step-by-step instructions and troubleshooting.

See [CONTEXTS.md](CONTEXTS.md) for choosing between private and Dedalus rule sets.

## Contents Overview

### Private Rules & Instructions

- **Code Quality**: Error handling patterns, code organization, naming conventions, complexity guidelines
- **Git Conventions**: Commit message format, branch naming, PR conventions
- **Security**: Input validation, secret management, dependency security
- **Documentation**: Code comments, README structure, API documentation
- **Language-specific**: TypeScript, Python, and security guidelines

### Dedalus Rules & Instructions

- **CFW Design System**: Component naming, color system, typography, layout patterns, theming
- **CFW Components**: Component usage patterns, import conventions, API guidelines
- **CFW Styling**: CSS variable usage, utility classes, custom styles, theme customization
- **Dedalus Conventions**: Angular patterns, project structure, testing requirements

### Shared Skills & Workflows

- **Code Review**: Review checklist, quality standards, feedback format
- **Commit Messages**: Conventional commits format, message structure, examples
- **Error Handling**: Exception handling patterns, error logging, user-facing messages
- **Testing**: Test structure, coverage guidelines, test naming conventions

## Contributing

- Keep rules in **rules/** (one source, no IDE-specific copies)
- Add or edit under **rules/private/** or **rules/dedalus/** as appropriate
- Scripts deploy to each IDE; no need to touch `.cursor` or `.github` in this repo

## License

[Specify your license here]
