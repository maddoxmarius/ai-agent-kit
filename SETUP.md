# Setup Guide

This guide provides detailed instructions for integrating the AI Agent Kit into your project as a git submodule.

## Prerequisites

- Git installed and configured
- Access to the AI Agent Kit repository
- Your project initialized as a git repository

## Choosing a Rule Set

This kit provides two rule sets:
- **Private**: Universal rules for personal/open-source projects
- **Dedalus**: CFW design system rules for Dedalus work

See [CONTEXTS.md](CONTEXTS.md) for guidance on choosing the right rule set.

## Integration Methods

### Method 1: Symlink (Recommended)

Symlinking preserves the connection to the submodule and allows easy updates.

#### For Private Projects (Cursor)

```bash
# 1. Add the submodule
git submodule add git@github.com:maddoxmarius/ai-agent-kit.git .ai-agent-kit

# 2. Create symlink for private Cursor rules
ln -s .ai-agent-kit/.cursor/rules/private .cursor/rules

# 3. Create .cursorignore to prevent loading Dedalus rules
cp .ai-agent-kit/.cursorignore.template-private .cursorignore

# 4. Verify the symlink
ls -la .cursor/rules
# Should show: .cursor/rules -> .ai-agent-kit/.cursor/rules/private

# 5. Commit the submodule reference and .cursorignore
git add .gitmodules .ai-agent-kit .cursor .cursorignore
git commit -m "Add AI Agent Kit submodule for Cursor (private rules)"
```

#### For Private Projects (GitHub Copilot)

```bash
# 1. Add the submodule
git submodule add <repository-url> .ai-agent-kit

# 2. Create symlink for private Copilot instructions
ln -s .ai-agent-kit/.github/instructions/private .github/instructions

# 3. Verify the symlink
ls -la .github/instructions
# Should show: .github/instructions -> .ai-agent-kit/.github/instructions/private

# 4. Commit the submodule reference
git add .gitmodules .ai-agent-kit .github
git commit -m "Add AI Agent Kit submodule for Copilot (private rules)"
```

#### For Dedalus Projects (Cursor)

```bash
# 1. Add the submodule
git submodule add git@github.com:maddoxmarius/ai-agent-kit.git .ai-agent-kit

# 2. Create symlink for Dedalus Cursor rules
ln -s .ai-agent-kit/.cursor/rules/dedalus .cursor/rules

# 3. Create .cursorignore to prevent loading Private rules
cp .ai-agent-kit/.cursorignore.template-dedalus .cursorignore

# 4. Verify the symlink
ls -la .cursor/rules
# Should show: .cursor/rules -> .ai-agent-kit/.cursor/rules/dedalus

# 5. Commit the submodule reference and .cursorignore
git add .gitmodules .ai-agent-kit .cursor .cursorignore
git commit -m "Add AI Agent Kit submodule for Cursor (Dedalus rules)"
```

#### For Dedalus Projects (GitHub Copilot)

```bash
# 1. Add the submodule
git submodule add <repository-url> .ai-agent-kit

# 2. Create symlink for Dedalus Copilot instructions
ln -s .ai-agent-kit/.github/instructions/dedalus .github/instructions

# 3. Copy Dedalus-specific copilot instructions
cp .ai-agent-kit/.github/copilot-instructions-dedalus.md .github/copilot-instructions.md

# 4. Verify the symlink and file
ls -la .github/instructions .github/copilot-instructions.md

# 5. Commit the submodule reference
git add .gitmodules .ai-agent-kit .github
git commit -m "Add AI Agent Kit submodule for Copilot (Dedalus rules)"
```

#### For Projects Using Both Cursor and Copilot

```bash
# 1. Add the submodule
git submodule add <repository-url> .ai-agent-kit

# 2. Choose your rule set (private or dedalus) and create symlinks
# For private:
ln -s .ai-agent-kit/.cursor/rules/private .cursor/rules
ln -s .ai-agent-kit/.github/instructions/private .github/instructions

# OR for Dedalus:
ln -s .ai-agent-kit/.cursor/rules/dedalus .cursor/rules
ln -s .ai-agent-kit/.github/instructions/dedalus .github/instructions
cp .ai-agent-kit/.github/copilot-instructions-dedalus.md .github/copilot-instructions.md

# 3. Verify symlinks
ls -la .cursor/rules .github/instructions

# 4. Commit the submodule reference
git add .gitmodules .ai-agent-kit .cursor .github
git commit -m "Add AI Agent Kit submodule for Cursor and Copilot"
```

### Method 2: Copy Files (Alternative)

If symlinks cause issues in your environment, you can copy files instead:

```bash
# Add the submodule
git submodule add <repository-url> .ai-agent-kit

# Copy private Cursor rules
mkdir -p .cursor/rules
cp -r .ai-agent-kit/.cursor/rules/private/* .cursor/rules/

# OR copy Dedalus Cursor rules
mkdir -p .cursor/rules
cp -r .ai-agent-kit/.cursor/rules/dedalus/* .cursor/rules/

# Copy private Copilot instructions
mkdir -p .github/instructions
cp -r .ai-agent-kit/.github/instructions/private/* .github/instructions/

# OR copy Dedalus Copilot instructions
mkdir -p .github/instructions
cp -r .ai-agent-kit/.github/instructions/dedalus/* .github/instructions/
cp .ai-agent-kit/.github/copilot-instructions-dedalus.md .github/copilot-instructions.md

# Commit
git add .cursor .github
git commit -m "Add AI Agent Kit configuration"
```

**Note**: With this method, you'll need to manually update files when the submodule changes.

## Verification

### Cursor Verification

1. Open Cursor in your project
2. Check that rules are accessible:
   - Open a file matching a rule's glob pattern
   - Rules should appear in Cursor's rule picker
3. Verify skills are available:
   - Skills should be discoverable by the AI agent
   - Check `.cursor/skills/` directory exists

### GitHub Copilot Verification

1. Open your project in VS Code or GitHub
2. Check that instructions are recognized:
   - `.github/copilot-instructions.md` should be at repository root
   - Path-specific instructions in `.github/instructions/` should be accessible
3. Test Copilot suggestions:
   - Create a new file matching a path-specific instruction
   - Copilot should apply relevant guidelines

## Updating the Submodule

When the AI Agent Kit is updated:

```bash
# Update to latest version
git submodule update --remote .ai-agent-kit

# If using symlinks, changes are automatically reflected
# If using copied files, you'll need to copy again:
# cp -r .ai-agent-kit/.cursor .cursor
# cp -r .ai-agent-kit/.github .github

# Commit the update
git add .ai-agent-kit
git commit -m "Update AI Agent Kit submodule"
```

## Troubleshooting

### Symlink Issues on Windows

Windows requires administrator privileges or Developer Mode for symlinks. Alternatives:

1. **Use Git Bash or WSL**: Symlinks work natively
2. **Use mklink** (Windows): `mklink /D .cursor .ai-agent-kit\.cursor`
3. **Copy files instead**: Use Method 2 above

### Submodule Not Found

If the submodule directory is empty:

```bash
# Initialize and update submodules
git submodule init
git submodule update

# Or clone with submodules
git clone --recurse-submodules <your-repo-url>
```

### Preventing Rule Conflicts

If Cursor is loading rules from both `private/` and `dedalus/` directories in the submodule, use one of these solutions:

#### Solution 1: Use .cursorignore (Recommended)

Create a `.cursorignore` file in your project root (not in the submodule) to exclude the unwanted rule set:

**For Private Projects:**
```bash
# Create .cursorignore in your project root
cat > .cursorignore << 'EOF'
# Exclude Dedalus rules from submodule
.ai-agent-kit/.cursor/rules/dedalus/
.ai-agent-kit/.github/instructions/dedalus/
.ai-agent-kit/.github/copilot-instructions-dedalus.md
EOF
```

**For Dedalus Projects:**
```bash
# Create .cursorignore in your project root
cat > .cursorignore << 'EOF'
# Exclude Private rules from submodule
.ai-agent-kit/.cursor/rules/private/
.ai-agent-kit/.github/instructions/private/
EOF
```

Templates are available in the kit:
- `.cursorignore.template-private` - Copy to your project as `.cursorignore`
- `.cursorignore.template-dedalus` - Copy to your project as `.cursorignore`

#### Solution 2: Configuration File (If Supported)

Copy `.cursor/config.json.template` to `.cursor/config.json` in your project and customize:

```json
{
  "rules": {
    "activeSet": "private",
    "excludeSets": ["dedalus"]
  }
}
```

**Note**: Verify that Cursor reads this config file. If not supported, use Solution 1.

#### Solution 3: Ensure Correct Symlinks

Make sure your symlinks point to the correct rule set:

```bash
# Verify symlink points to correct directory
ls -la .cursor/rules
# Should show: .cursor/rules -> .ai-agent-kit/.cursor/rules/private
# OR: .cursor/rules -> .ai-agent-kit/.cursor/rules/dedalus
```

### Cursor Not Recognizing Rules

1. Verify symlink is correct: `ls -la .cursor/rules`
2. Check symlink points to correct directory (private or dedalus)
3. Check rule files exist: `ls .cursor/rules/`
4. Ensure rule files have `.mdc` extension
5. Check `.cursorignore` doesn't exclude your rules
6. Restart Cursor

### Copilot Not Applying Instructions

1. Verify `.github/copilot-instructions.md` exists at repository root
2. Check file naming: must be exactly `copilot-instructions.md`
3. Ensure instructions are in `.github/instructions/` directory
4. Restart VS Code or refresh GitHub

### Conflicting .github Directory

If your project already has a `.github` directory:

```bash
# Option 1: Merge directories (for private rules)
cp -r .ai-agent-kit/.github/instructions/private/* .github/instructions/

# Option 2: Use selective symlinks
ln -s ../../.ai-agent-kit/.github/instructions/private .github/instructions
# OR for Dedalus:
ln -s ../../.ai-agent-kit/.github/instructions/dedalus .github/instructions
cp .ai-agent-kit/.github/copilot-instructions-dedalus.md .github/copilot-instructions.md
```

### Switching Between Rule Sets

To switch from private to Dedalus (or vice versa):

```bash
# Remove existing symlink
rm .cursor/rules .github/instructions

# Create new symlink for desired rule set
ln -s .ai-agent-kit/.cursor/rules/dedalus .cursor/rules
ln -s .ai-agent-kit/.github/instructions/dedalus .github/instructions
cp .ai-agent-kit/.github/copilot-instructions-dedalus.md .github/copilot-instructions.md

# Commit changes
git add .cursor .github
git commit -m "Switch to Dedalus rule set"
```

## Customization

### Adding Project-Specific Rules

Create project-specific rules alongside the kit:

```bash
# Project-specific Cursor rules
.cursor/rules/project-specific.mdc

# Project-specific Copilot instructions
.github/instructions/project.instructions.md
```

These will work alongside the kit's universal rules.

### Overriding Kit Rules

If you need to override a kit rule:

1. Create a rule with the same name in your project
2. Your project's rule takes precedence
3. Or modify the symlinked files directly (changes will be lost on update)

## Best Practices

1. **Keep kit updated**: Regularly update the submodule to get latest improvements
2. **Don't modify kit files directly**: Create project-specific overrides instead
3. **Document customizations**: Note any project-specific additions in your README
4. **Use symlinks**: Prefer symlinks over copying for easier updates
5. **Version pinning**: Consider pinning to a specific commit for stability:
   ```bash
   cd .ai-agent-kit
   git checkout <commit-hash>
   cd ..
   git add .ai-agent-kit
   git commit -m "Pin AI Agent Kit to specific version"
   ```

## Uninstalling

To remove the AI Agent Kit:

```bash
# Remove symlinks
rm .cursor .github

# Remove submodule
git submodule deinit .ai-agent-kit
git rm .ai-agent-kit
rm -rf .git/modules/.ai-agent-kit

# Commit removal
git commit -m "Remove AI Agent Kit submodule"
```
