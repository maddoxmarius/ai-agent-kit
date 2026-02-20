# AI Agent Kit

A reusable git submodule containing AI agent rules, instructions, and skills compatible with both **Cursor** and **GitHub Copilot**. This kit provides coding standards, best practices, and workflows that can be shared across multiple projects.

## Rule Sets

This kit includes two separate rule sets:

- **Private Rules**: Universal rules for personal/open-source projects
- **Dedalus Rules**: CFW (U Client Framework) design system rules for Dedalus work

Projects can selectively enable the appropriate rule set. See [CONTEXTS.md](CONTEXTS.md) for guidance on choosing the right rule set.

## What's Included

### Cursor Configuration
- **Rules** (`.cursor/rules/private/` or `.cursor/rules/dedalus/`): Context-specific coding standards
- **Skills** (`.cursor/skills/`): Shared workflows (code review, commit messages, error handling, testing)

### GitHub Copilot Configuration
- **Repository-wide instructions**: Universal or context-specific instructions
- **Path-specific instructions** (`.github/instructions/private/` or `.github/instructions/dedalus/`): Language and domain-specific guidelines
- **Agent instructions** (`AGENTS.md`): Agent-specific configuration

## Quick Start

### For Private Projects

```bash
# Add this repository as a submodule
git submodule add git@github.com:maddoxmarius/ai-agent-kit.git .ai-agent-kit

# Symlink private rules for Cursor
ln -s .ai-agent-kit/.cursor/rules/private .cursor/rules

# Create .cursorignore to prevent loading Dedalus rules
cp .ai-agent-kit/.cursorignore.template-private .cursorignore

# Symlink private instructions for Copilot
ln -s .ai-agent-kit/.github/instructions/private .github/instructions
```

### For Dedalus Projects

```bash
# Add this repository as a submodule
git submodule add git@github.com:maddoxmarius/ai-agent-kit.git .ai-agent-kit

# Symlink dedalus rules for Cursor
ln -s .ai-agent-kit/.cursor/rules/dedalus .cursor/rules

# Create .cursorignore to prevent loading Private rules
cp .ai-agent-kit/.cursorignore.template-dedalus .cursorignore

# Symlink dedalus instructions for Copilot
ln -s .ai-agent-kit/.github/instructions/dedalus .github/instructions

# Copy dedalus-specific copilot instructions
cp .ai-agent-kit/.github/copilot-instructions-dedalus.md .github/copilot-instructions.md
```

### Verification

**Cursor:**
- Check that `.cursor/rules/` and `.cursor/skills/` are accessible
- Rules should appear in Cursor's rule picker
- Skills should be available to the AI agent

**GitHub Copilot:**
- Verify `.github/copilot-instructions.md` exists
- Check that path-specific instructions in `.github/instructions/` are recognized
- Copilot should apply instructions automatically

## Preventing Rule Conflicts

If Cursor is loading rules from both `private/` and `dedalus/` directories, create a `.cursorignore` file in your project root:

**For Private Projects:**
```bash
cp .ai-agent-kit/.cursorignore.template-private .cursorignore
```

**For Dedalus Projects:**
```bash
cp .ai-agent-kit/.cursorignore.template-dedalus .cursorignore
```

This prevents Cursor from scanning the unwanted rule set in the submodule. See [SETUP.md](SETUP.md) for more details and alternative solutions.

## Detailed Setup

See [SETUP.md](SETUP.md) for comprehensive integration instructions, troubleshooting, and advanced configuration options.

See [CONTEXTS.md](CONTEXTS.md) for guidance on choosing between private and Dedalus rule sets.

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

## Compatibility

This kit is designed to work with:
- **Cursor**: Uses `.cursor/rules/` (`.mdc` format) and `.cursor/skills/` (`SKILL.md` format)
- **GitHub Copilot**: Uses `.github/copilot-instructions.md` and `.github/instructions/*.instructions.md`

Both configurations share similar content but use different formats optimized for each tool.

## Contributing

When adding new rules or skills:
- Keep content concise and universal (applicable to most projects)
- Provide concrete examples
- Use clear, actionable language
- Avoid project-specific details

## License

[Specify your license here]
