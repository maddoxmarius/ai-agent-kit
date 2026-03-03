# Context Selection Guide

Choose **private** or **dedalus** when running the install scripts. All rules live under **rules/private/** or **rules/dedalus/**; the scripts copy only the selected set into your project.

## Rule Set Overview

### Private

- Universal code quality, git, security, documentation
- TypeScript, Python, security path-specific instructions

**Use when:** Personal projects, open source, or any project not using Dedalus CFW.

### Dedalus

- CFW design system, components, styling
- Dedalus conventions and git (e.g. ticket numbers)
- CFW path-specific instructions

**Use when:** Dedalus projects using U Client Framework (CFW).

## Quick decision

```
Using Dedalus CFW?  YES → dedalus
                    NO  → private
```

## Rule set contents

### rules/private/

- **Rules (Cursor)**: code-quality.md, git-conventions.md, security.md, documentation.md, logging.md
- **Copilot main**: _main.md → copilot-instructions.md
- **Copilot path-specific**: typescript.instructions.md, python.instructions.md, security.instructions.md

### rules/dedalus/

- **Rules (Cursor)**: cfw-design-system.md, cfw-components.md, cfw-styling.md, dedalus-conventions.md, dedalus-git-conventions.md
- **Copilot main**: _main.md → copilot-instructions.md
- **Copilot path-specific**: cfw-design.instructions.md, cfw-components.instructions.md

### skills/ (shared)

- Code review, commit messages, error handling, jira-issue-details, testing, frontend-design (installed for Cursor only)

## Examples

**Private project (Cursor + Copilot):**
```bash
.ai-agent-kit/scripts/install-cursor.sh private
.ai-agent-kit/scripts/install-copilot.sh private
```

**Dedalus project (Cursor + Copilot):**
```bash
.ai-agent-kit/scripts/install-cursor.sh dedalus
.ai-agent-kit/scripts/install-copilot.sh dedalus
```

## Switching context

Re-run the install scripts with the other context; they overwrite the previously installed rules and instructions.
