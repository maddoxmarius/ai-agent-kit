---
description: Git workflow standards including commit message format, branch naming conventions, and PR best practices
alwaysApply: true
ruleSet: private
---

# Git Conventions

## Commit Message Format

Use [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Commit Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, semicolons, etc.)
- **refactor**: Code refactoring without changing functionality
- **test**: Adding or updating tests
- **chore**: Maintenance tasks, dependency updates
- **perf**: Performance improvements
- **ci**: CI/CD changes
- **build**: Build system changes

### Examples

```bash
# Good commit messages
feat(auth): add JWT token validation
fix(api): resolve null pointer exception in user endpoint
docs(readme): update installation instructions
refactor(utils): extract date formatting logic
test(auth): add unit tests for token validation

# Bad commit messages
update code
fix bug
changes
WIP
```

### Commit Message Guidelines

- **Subject line**: 
  - Use imperative mood ("add" not "added" or "adds")
  - First letter lowercase (unless starting with proper noun)
  - No period at the end
  - Maximum 72 characters
  
- **Body** (optional):
  - Explain "what" and "why", not "how"
  - Wrap at 72 characters
  - Separate from subject with blank line
  
- **Footer** (optional):
  - Reference issues: `Closes #123`
  - Breaking changes: `BREAKING CHANGE: description`

### Complete Example

```
feat(api): implement user authentication endpoint

Add POST /api/auth/login endpoint with JWT token generation.
Includes input validation and error handling.

Closes #42
```

## Branch Naming

Use descriptive branch names with prefixes:

### Branch Prefixes

- `feature/` - New features
- `fix/` - Bug fixes
- `hotfix/` - Urgent production fixes
- `docs/` - Documentation updates
- `refactor/` - Code refactoring
- `test/` - Test additions/changes
- `chore/` - Maintenance tasks

### Examples

```bash
feature/user-authentication
fix/login-validation-error
docs/api-documentation
refactor/payment-processing
hotfix/security-patch
```

### Branch Naming Guidelines

- Use kebab-case (lowercase with hyphens)
- Be descriptive but concise
- Include issue number if applicable: `feature/123-user-dashboard`
- Avoid generic names: `update`, `changes`, `fix`

## Pull Request Conventions

### PR Title

Follow commit message format:

```
feat(auth): add password reset functionality
```

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No new warnings generated
- [ ] Tests pass locally
```

### PR Best Practices

- **Keep PRs focused**: One logical change per PR
- **Write clear descriptions**: Explain what and why
- **Link related issues**: Reference issues being addressed
- **Request reviews**: Get feedback before merging
- **Keep PRs small**: Easier to review and merge
- **Update documentation**: Include docs changes when needed
- **Ensure tests pass**: All CI checks should pass

## Git Workflow

### Before Committing

1. **Review changes**: `git diff` or `git status`
2. **Stage selectively**: `git add <file>` not `git add .`
3. **Write clear message**: Follow commit message format
4. **Test locally**: Ensure code works before committing

### Commit Frequency

- **Commit often**: Small, logical commits are better
- **Commit related changes together**: Don't mix unrelated changes
- **Don't commit broken code**: Fix issues before committing
- **Don't commit temporary files**: Use `.gitignore`

### Branch Management

- **Create branches from main**: Start fresh from latest main
- **Keep branches up to date**: Regularly merge/rebase from main
- **Delete merged branches**: Clean up after merging
- **Use descriptive names**: Make purpose clear

## .gitignore Best Practices

Include common patterns:

```
# Dependencies
node_modules/
vendor/
*.lock

# Build outputs
dist/
build/
*.o
*.exe

# IDE files
.vscode/
.idea/
*.swp
*.swo

# Environment files
.env
.env.local
*.key

# OS files
.DS_Store
Thumbs.db
```

## Tagging

Use semantic versioning for tags:

```
v1.0.0
v1.1.0
v2.0.0
```

Tag important releases:
- Major releases
- Security patches
- Significant milestones
