# Context Selection Guide

This guide helps you choose between **Private** and **Dedalus** rule sets when integrating the AI Agent Kit into your project.

## Rule Set Overview

### Private Rules

Universal rules for personal/open-source projects:
- Generic code quality standards
- Universal git conventions
- General security best practices
- Standard documentation guidelines
- Language-specific patterns (TypeScript, Python)

**Use when:**
- Working on personal projects
- Contributing to open-source projects
- Building generic applications
- Not using Dedalus CFW design system

### Dedalus Rules

CFW (U Client Framework) design system rules for Dedalus work:
- CFW component naming conventions (`u-` prefix)
- CFW color system (CSS variables)
- CFW typography system
- CFW layout patterns
- CFW theming guidelines
- Dedalus-specific Angular patterns
- Dedalus project structure conventions

**Use when:**
- Working on Dedalus projects
- Using U Client Framework (CFW)
- Building applications with CFW components
- Following Dedalus coding conventions

## Quick Decision Guide

```
Is this a Dedalus project using CFW?
├─ YES → Use Dedalus rules
└─ NO  → Use Private rules
```

## Rule Set Contents

### Private Rules Include

**Cursor Rules** (`.cursor/rules/private/`):
- `code-quality.mdc` - Universal code quality standards
- `git-conventions.mdc` - Git workflow standards
- `security.mdc` - Security best practices
- `documentation.mdc` - Documentation standards

**Copilot Instructions** (`.github/instructions/private/`):
- `typescript.instructions.md` - TypeScript patterns
- `python.instructions.md` - Python patterns
- `security.instructions.md` - Security guidelines

### Dedalus Rules Include

**Cursor Rules** (`.cursor/rules/dedalus/`):
- `cfw-design-system.mdc` - CFW design system guidelines
- `cfw-components.mdc` - CFW component usage patterns
- `cfw-styling.mdc` - CFW styling guidelines
- `dedalus-conventions.mdc` - Dedalus-specific conventions

**Copilot Instructions** (`.github/instructions/dedalus/`):
- `cfw-design.instructions.md` - CFW design system instructions
- `cfw-components.instructions.md` - CFW component usage instructions
- `.github/copilot-instructions-dedalus.md` - Dedalus-specific main instructions

## Shared Resources

Both rule sets share the same **Skills** (`.cursor/skills/`):
- Code review workflows
- Commit message generation
- Error handling patterns
- Testing best practices

These are context-agnostic and work with both rule sets.

## Examples

### Example 1: Personal TypeScript Project

**Project**: Personal blog built with TypeScript and React

**Rule Set**: Private
- Uses generic TypeScript patterns
- No CFW components
- Standard git conventions

**Setup**:
```bash
ln -s .ai-agent-kit/.cursor/rules/private .cursor/rules
ln -s .ai-agent-kit/.github/instructions/private .github/instructions
```

### Example 2: Dedalus CFW Application

**Project**: Healthcare application using CFW design system

**Rule Set**: Dedalus
- Uses CFW components (`<u-button>`, `<u-grid>`, etc.)
- Follows CFW color and typography system
- Uses Dedalus Angular patterns

**Setup**:
```bash
ln -s .ai-agent-kit/.cursor/rules/dedalus .cursor/rules
ln -s .ai-agent-kit/.github/instructions/dedalus .github/instructions
cp .ai-agent-kit/.github/copilot-instructions-dedalus.md .github/copilot-instructions.md
```

### Example 3: Mixed Project

**Project**: Project that uses both generic patterns and CFW components

**Rule Set**: Both (combined)

**Setup**:
```bash
# Create combined structure
mkdir -p .cursor/rules .github/instructions

# Symlink both rule sets
ln -s ../../.ai-agent-kit/.cursor/rules/private/* .cursor/rules/
ln -s ../../.ai-agent-kit/.cursor/rules/dedalus/* .cursor/rules/
ln -s ../../.ai-agent-kit/.github/instructions/private/* .github/instructions/
ln -s ../../.ai-agent-kit/.github/instructions/dedalus/* .github/instructions/
```

## Migration Guide

### Switching from Private to Dedalus

If you're migrating a project to use CFW:

```bash
# 1. Remove private rule symlinks
rm .cursor/rules .github/instructions

# 2. Create Dedalus rule symlinks
ln -s .ai-agent-kit/.cursor/rules/dedalus .cursor/rules
ln -s .ai-agent-kit/.github/instructions/dedalus .github/instructions
cp .ai-agent-kit/.github/copilot-instructions-dedalus.md .github/copilot-instructions.md

# 3. Commit changes
git add .cursor .github
git commit -m "Migrate to Dedalus CFW rules"
```

### Switching from Dedalus to Private

If you're moving away from CFW:

```bash
# 1. Remove Dedalus rule symlinks
rm .cursor/rules .github/instructions .github/copilot-instructions.md

# 2. Create private rule symlinks
ln -s .ai-agent-kit/.cursor/rules/private .cursor/rules
ln -s .ai-agent-kit/.github/instructions/private .github/instructions

# 3. Commit changes
git add .cursor .github
git commit -m "Switch to private rules"
```

## Best Practices

1. **Choose one primary rule set**: Use private OR dedalus, not both (unless combining)
2. **Be consistent**: Use the same rule set across all team members
3. **Document your choice**: Note in project README which rule set is used
4. **Update when needed**: Switch rule sets if project context changes

## Troubleshooting

### Rules Not Applying

- Verify symlink points to correct directory (`private` or `dedalus`)
- Check that rule files exist in the symlinked directory
- Restart Cursor/VS Code after changing symlinks

### Conflicting Rules

- If using both rule sets, ensure rules don't conflict
- Private rules are more generic; Dedalus rules are CFW-specific
- Dedalus rules take precedence for CFW-specific patterns

## Questions?

- See [SETUP.md](SETUP.md) for detailed setup instructions
- See [README.md](README.md) for general overview
- Check rule files directly for specific guidelines
