# GitHub Copilot Instructions

These instructions apply to all code in this repository. Follow these guidelines when writing code, reviewing changes, or suggesting improvements.

## Code Quality Standards

### Error Handling

Always handle errors explicitly. Never use empty catch blocks or ignore errors.

- Use try-catch blocks for error handling
- Provide meaningful error messages with context
- Log errors appropriately with relevant information
- Use specific error types for different failure modes
- Fail fast when encountering invalid states

### Code Organization

- Keep functions small and focused (under 50 lines when possible)
- Each function should have a single responsibility
- Use clear, descriptive names for variables, functions, and classes
- Avoid deep nesting - prefer early returns and guard clauses
- Extract complex logic into separate functions

### Logging

- Use emojis in log messages to improve scanability (e.g. 🔴 errors, ⚠️ warnings, ✅ info/success, 🔍 debug).
- Put the emoji at the start of the message string and use one emoji per log line consistently across the codebase.

### Naming Conventions

- Use descriptive names that explain intent
- Prefer full words over abbreviations
- Use verbs for functions, nouns for variables
- Use PascalCase for classes and types
- Be consistent with naming patterns throughout the codebase

## Security Best Practices

### Secret Management

- Never hardcode secrets, API keys, or credentials
- Use environment variables for configuration
- Store secrets in secure secret management services
- Never commit secrets to version control
- Use different secrets for each environment

### Input Validation

- Validate and sanitize all user inputs
- Use parameterized queries for database operations
- Escape output to prevent XSS attacks
- Validate data types, formats, and ranges
- Implement rate limiting to prevent abuse

### Authentication & Authorization

- Hash passwords using strong algorithms (bcrypt, argon2)
- Implement proper authentication checks
- Verify authorization before sensitive operations
- Use secure session management
- Implement 2FA for sensitive operations

## Git Conventions

### Commit Messages

Use Conventional Commits format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`

Examples:
- `feat(auth): add JWT token validation`
- `fix(api): resolve null pointer in user endpoint`
- `docs(readme): update installation instructions`

### Branch Naming

Use descriptive branch names with prefixes:
- `feature/` - New features
- `fix/` - Bug fixes
- `hotfix/` - Urgent production fixes
- `docs/` - Documentation updates
- `refactor/` - Code refactoring

## Documentation Standards

### Code Comments

- Write self-documenting code with clear naming
- Add comments only when necessary to explain "why", not "what"
- Document complex algorithms and business logic
- Use JSDoc/TSDoc for public APIs
- Keep comments up-to-date with code changes

### README Files

- Start with a clear description of what the project does
- Include installation and usage instructions
- Provide examples and code samples
- Document configuration options
- Keep documentation current

## Testing Guidelines

### Test Coverage

- Write tests for critical functionality
- Aim for reasonable test coverage (70-80% overall)
- Test edge cases and error conditions
- Use descriptive test names
- Keep tests independent and isolated

### Test Structure

- Follow Arrange-Act-Assert pattern
- One concept per test
- Group related tests with describe blocks
- Clean up after tests (use beforeEach/afterEach)

## General Principles

### Keep It Simple

- Prefer simple solutions over clever ones
- Write code that is easy to understand
- Avoid premature optimization
- Refactor regularly to improve code quality

### Consistency

- Follow project conventions and style guides
- Use consistent patterns throughout the codebase
- Maintain consistent error handling approaches
- Keep naming conventions consistent

### Best Practices

- Review code before committing
- Write self-documenting code
- Handle errors explicitly
- Keep dependencies updated
- Document complex decisions

## When Writing Code

1. **Think about maintainability**: Will others understand this code?
2. **Consider edge cases**: What could go wrong?
3. **Handle errors gracefully**: Provide helpful error messages
4. **Write tests**: Ensure code works as expected
5. **Document complex logic**: Explain non-obvious decisions

## Anti-Patterns to Avoid

- Don't ignore errors or use empty catch blocks
- Don't commit commented-out code
- Don't use magic numbers or strings
- Don't create overly complex abstractions
- Don't skip error handling for "simple" operations
- Don't hardcode configuration values
- Don't write code without tests for critical paths
