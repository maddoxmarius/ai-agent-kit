---
name: commit-messages
description: Generate descriptive commit messages following Conventional Commits format. Use when the user asks for help writing commit messages, reviewing staged changes, or generating commit messages from diffs.
---

# Commit Messages

## Format

Use [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

## Commit Types

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

## Subject Line Guidelines

- Use imperative mood: "add" not "added" or "adds"
- First letter lowercase (unless starting with proper noun)
- No period at the end
- Maximum 72 characters
- Be specific and descriptive

### Good Subject Lines
```
feat(auth): add JWT token validation
fix(api): resolve null pointer in user endpoint
docs(readme): update installation instructions
refactor(utils): extract date formatting logic
```

### Bad Subject Lines
```
update code
fix bug
changes
WIP
feat: stuff
```

## Body (Optional)

Use body for:
- Explaining "what" and "why", not "how"
- Providing context or background
- Describing breaking changes
- Referencing issues

### Body Guidelines
- Wrap at 72 characters
- Separate from subject with blank line
- Use present tense
- Focus on motivation, not implementation

### Example Body
```
feat(api): add user authentication endpoint

Add POST /api/auth/login endpoint with JWT token generation.
This enables secure user sessions without server-side session storage.

Implements the authentication flow described in issue #42.
```

## Footer (Optional)

Use footer for:
- Referencing issues: `Closes #123`, `Fixes #456`
- Breaking changes: `BREAKING CHANGE: description`
- Co-authors: `Co-authored-by: Name <email>`

### Example Footer
```
Closes #42
BREAKING CHANGE: API endpoint changed from /users to /api/users
```

## Examples

### Feature Addition
```
feat(payment): add credit card processing

Integrate Stripe API for credit card payments.
Includes validation, error handling, and webhook support.

Closes #123
```

### Bug Fix
```
fix(login): resolve authentication timeout issue

Fix issue where login requests timeout after 30 seconds.
Increased timeout to 60 seconds and added retry logic.

Fixes #456
```

### Documentation
```
docs(api): add endpoint documentation

Document all REST API endpoints with request/response examples.
Include authentication requirements and error codes.
```

### Refactoring
```
refactor(database): extract query builder

Move database query logic into separate QueryBuilder class.
Improves testability and reduces coupling.

No functional changes.
```

### Breaking Change
```
feat(api): migrate to v2 authentication

BREAKING CHANGE: Authentication now requires API key in header.
Old token-based auth is deprecated and will be removed in v3.

Migration guide: docs/migration/v2-auth.md
```

## Generating from Diffs

When generating commit messages from git diffs:

1. **Analyze changes**: Understand what was modified
2. **Identify type**: Determine the commit type
3. **Find scope**: Identify the affected area/module
4. **Write subject**: Summarize the change
5. **Add body**: Explain context if needed
6. **Add footer**: Reference issues if applicable

### Example Process

**Diff shows:**
- Added `validateEmail()` function
- Updated `createUser()` to use validation
- Added tests for email validation

**Generated commit:**
```
feat(auth): add email validation

Add validateEmail() function to check email format.
Update createUser() to validate emails before creation.
Includes comprehensive test coverage.

Closes #789
```

## Best Practices

- **One logical change per commit**: Don't mix unrelated changes
- **Write clear messages**: Future you (and others) will thank you
- **Reference issues**: Link to related issues or PRs
- **Be consistent**: Follow the same format across the project
- **Review before committing**: Check your message makes sense

## Common Mistakes to Avoid

- ❌ Vague messages: "update", "fix", "changes"
- ❌ Present tense in subject: "adds feature" instead of "add feature"
- ❌ Too long: Subject over 72 characters
- ❌ Mixed concerns: Multiple unrelated changes in one commit
- ❌ No type prefix: Missing `feat:`, `fix:`, etc.
