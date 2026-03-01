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

---


# Code Quality Standards

## Error Handling

Always handle errors explicitly. Never use empty catch blocks or ignore errors.

```typescript
// ❌ BAD
try {
  await fetchData();
} catch (e) {}

// ✅ GOOD
try {
  await fetchData();
} catch (error) {
  logger.error('Failed to fetch data', { error });
  throw new DataFetchError('Unable to retrieve data', { cause: error });
}
```

### Error Handling Principles

- **Fail fast**: Detect invalid states early and fail immediately
- **Provide context**: Include relevant information in error messages
- **Use appropriate types**: Create specific error types for different failure modes
- **Log appropriately**: Log errors with sufficient context for debugging
- **Handle gracefully**: Where possible, provide fallbacks or user-friendly messages

## Code Organization

### Function Design

- **Single responsibility**: Each function should do one thing well
- **Small and focused**: Keep functions under 50 lines when possible
- **Clear naming**: Function names should clearly describe what they do
- **Avoid side effects**: Prefer pure functions when possible

```typescript
// ❌ BAD
function processUser(data) {
  validate(data);
  saveToDb(data);
  sendEmail(data.email);
  updateCache(data.id);
  logActivity(data);
}

// ✅ GOOD
function processUser(userData: UserData): void {
  const validatedData = validateUserData(userData);
  persistUser(validatedData);
  notifyUser(validatedData.email);
}
```

### File Organization

- **One main export per file**: Keep files focused on a single concept
- **Group related code**: Keep related functions, types, and constants together
- **Separate concerns**: Split business logic from presentation, data access from domain logic

## Naming Conventions

### Variables and Functions

- Use descriptive names that explain intent
- Prefer full words over abbreviations
- Use verbs for functions, nouns for variables
- Be consistent with naming patterns

```typescript
// ❌ BAD
const d = new Date();
function calc(x, y) { return x + y; }
const usr = getUser();

// ✅ GOOD
const currentDate = new Date();
function calculateTotal(price: number, tax: number): number {
  return price + tax;
}
const user = getUser();
```

### Classes and Types

- Use PascalCase for classes and types
- Use descriptive names that indicate purpose
- Avoid generic names like `Manager`, `Handler`, `Processor`

```typescript
// ❌ BAD
class Manager {}
class Handler {}
interface Data {}

// ✅ GOOD
class UserRepository {}
class PaymentProcessor {}
interface UserProfile {}
```

## Complexity Guidelines

### Cyclomatic Complexity

- Keep functions simple: aim for complexity < 10
- Extract complex logic into separate functions
- Use early returns to reduce nesting

```typescript
// ❌ BAD
function processOrder(order) {
  if (order) {
    if (order.items) {
      if (order.items.length > 0) {
        if (order.customer) {
          if (order.customer.verified) {
            // process order
          }
        }
      }
    }
  }
}

// ✅ GOOD
function processOrder(order: Order): void {
  if (!order || !order.items?.length || !order.customer?.verified) {
    throw new InvalidOrderError('Order validation failed');
  }
  executeOrderProcessing(order);
}
```

### Cognitive Load

- Minimize mental overhead: make code easy to understand at a glance
- Avoid deep nesting: prefer early returns and guard clauses
- Extract magic numbers: use named constants
- Clarify intent: use intermediate variables for complex expressions

## Code Smells to Avoid

- **Long parameter lists**: Use objects or configuration objects instead
- **God objects**: Classes that know or do too much
- **Feature envy**: Functions that use more of another object's data than their own
- **Duplication**: Extract common patterns into reusable functions
- **Dead code**: Remove unused code, don't comment it out

## Best Practices

- **Write self-documenting code**: Code should explain itself
- **Keep it simple**: Prefer simple solutions over clever ones
- **Refactor regularly**: Improve code quality incrementally
- **Review before committing**: Check your own code before submitting
- **Follow project conventions**: Consistency is important

---


# Documentation Standards

## Code Comments

### When to Comment

- **Explain "why", not "what"**: Code should be self-explanatory
- **Document complex algorithms**: Explain non-obvious logic
- **Clarify business rules**: Document domain-specific decisions
- **Note workarounds**: Explain temporary fixes or known issues
- **API documentation**: Document public interfaces

### Comment Guidelines

```typescript
// ❌ BAD - Comments the obvious
// Increment counter by 1
counter++;

// ✅ GOOD - Explains why
// Use bitwise OR for faster flag combination
// See: https://example.com/performance-analysis
flags |= FLAG_ENABLED;

// ❌ BAD - Outdated comment
// TODO: Fix this bug (fixed in commit abc123)

// ✅ GOOD - Explains business logic
// Round down to nearest cent to match accounting system requirements
const amount = Math.floor(price * 100) / 100;
```

### Comment Types

- **Inline comments**: Brief explanations on the same line
- **Block comments**: Multi-line explanations for complex logic
- **Function documentation**: JSDoc/TSDoc for public APIs
- **File headers**: Copyright, license, purpose (when needed)

### Function Documentation

```typescript
// ✅ GOOD - JSDoc/TSDoc format
/**
 * Calculates the total price including tax.
 * 
 * @param basePrice - The base price before tax
 * @param taxRate - The tax rate as a decimal (e.g., 0.08 for 8%)
 * @returns The total price including tax, rounded to 2 decimal places
 * @throws {ValidationError} If basePrice is negative or taxRate is invalid
 * 
 * @example
 * ```typescript
 * const total = calculateTotalWithTax(100, 0.08);
 * // Returns: 108.00
 * ```
 */
function calculateTotalWithTax(basePrice: number, taxRate: number): number {
  if (basePrice < 0) {
    throw new ValidationError('Base price cannot be negative');
  }
  if (taxRate < 0 || taxRate > 1) {
    throw new ValidationError('Tax rate must be between 0 and 1');
  }
  return Math.round((basePrice * (1 + taxRate)) * 100) / 100;
}
```

## README Structure

### Essential Sections

```markdown
# Project Name

Brief one-line description of what the project does.

## Features

- Key feature 1
- Key feature 2
- Key feature 3

## Installation

Step-by-step installation instructions.

## Usage

Basic usage examples.

## Configuration

Configuration options and environment variables.

## Development

How to set up development environment.

## Testing

How to run tests.

## Contributing

Guidelines for contributors.

## License

License information.
```

### README Best Practices

- **Start with purpose**: What does this project do?
- **Include examples**: Show how to use the project
- **Keep it updated**: Update README when code changes
- **Use clear structure**: Organize with headers and lists
- **Add badges**: Build status, version, license
- **Include screenshots**: For UI projects
- **Link to docs**: For detailed documentation

## API Documentation

### REST API Documentation

```markdown
## API Endpoints

### POST /api/users

Create a new user.

**Request Body:**
```json
{
  "email": "user@example.com",
  "name": "John Doe",
  "password": "securepassword"
}
```

**Response (201 Created):**
```json
{
  "id": "123",
  "email": "user@example.com",
  "name": "John Doe",
  "createdAt": "2024-01-01T00:00:00Z"
}
```

**Errors:**
- `400 Bad Request`: Invalid input data
- `409 Conflict`: Email already exists
```

### API Documentation Standards

- **Document all endpoints**: Include request/response formats
- **Show examples**: Provide curl or code examples
- **Document errors**: List possible error responses
- **Include authentication**: Explain auth requirements
- **Version APIs**: Use versioning for breaking changes

## Code Documentation Tools

### TypeScript/JavaScript

- **JSDoc/TSDoc**: Standard documentation format
- **TypeDoc**: Generate HTML documentation from comments
- **ESDoc**: Alternative documentation generator

### Python

- **Docstrings**: Use PEP 257 style
- **Sphinx**: Generate documentation from docstrings
- **pydoc**: Built-in documentation generator

### General

- **Markdown**: For README and guides
- **OpenAPI/Swagger**: For API documentation
- **Architecture Decision Records (ADRs)**: Document decisions

## Documentation Maintenance

### Keep Documentation Updated

- **Update with code changes**: Don't let docs get stale
- **Review during code review**: Check if docs need updates
- **Remove outdated docs**: Delete or archive old documentation
- **Version documentation**: Keep docs aligned with code versions

### Documentation Review Checklist

- [ ] README is up-to-date
- [ ] API documentation matches implementation
- [ ] Code comments explain complex logic
- [ ] Examples work and are current
- [ ] Installation instructions are accurate
- [ ] Configuration options are documented
- [ ] Breaking changes are noted

## Writing Good Documentation

### Clarity

- **Use simple language**: Avoid jargon when possible
- **Be concise**: Get to the point quickly
- **Use examples**: Show, don't just tell
- **Organize logically**: Group related information

### Completeness

- **Cover all use cases**: Document common scenarios
- **Include edge cases**: Note limitations and gotchas
- **Provide context**: Explain when and why to use features
- **Link related docs**: Connect related information

### Accuracy

- **Test examples**: Ensure code examples work
- **Verify facts**: Check that information is correct
- **Update regularly**: Keep documentation current
- **Review carefully**: Proofread before publishing

## Documentation Anti-Patterns

- **Don't comment obvious code**: `// Set x to 5` is useless
- **Don't duplicate code in comments**: Comments should add value
- **Don't leave TODOs**: Either do it or create an issue
- **Don't write novels**: Keep comments concise
- **Don't forget to update**: Outdated docs are worse than no docs

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

---


# Logging with Emojis

Use emojis when writing log messages so that log levels and intent are easy to spot when scanning logs.

## When to Use Emojis

- **All log levels**: Prefix or include an emoji that matches the intent of the message
- **Structured logging**: Prefer a leading emoji in the message string so it appears in every line
- **Consistency**: Use the same emoji for the same kind of event across the codebase

## Recommended Emojis by Intent

| Intent / Level   | Emoji | Example use |
|------------------|-------|-------------|
| Error / failure  | 🔴 or ❌ | Exceptions, failed operations |
| Warning         | ⚠️ or 🟡 | Deprecations, fallbacks, recoverable issues |
| Info / success  | ℹ️ or ✅ | Startup, shutdown, key milestones |
| Debug           | 🔍 or 🐛 | Detailed state, trace data |
| HTTP / request  | 🌐 or 📡 | Incoming/outgoing requests |
| Database        | 🗄️ or 💾 | Queries, migrations, persistence |
| Security        | 🔒 or 🛡️ | Auth, validation, secrets |
| Performance     | ⚡ or 📊 | Timings, metrics |

Choose one set and use it consistently in the project.

## Examples

```typescript
// ❌ BAD - No emoji, harder to scan
logger.error('Failed to fetch data', { error });
logger.info('Server started on port 3000');
logger.warn('Cache miss for key', { key });

// ✅ GOOD - Emoji clarifies intent at a glance
logger.error('🔴 Failed to fetch data', { error });
logger.info('✅ Server started on port 3000');
logger.warn('⚠️ Cache miss for key', { key });
```

```python
# ❌ BAD
logger.error("Database connection failed: %s", e)
logger.info("Request completed in %d ms", duration)

# ✅ GOOD
logger.error("🔴 Database connection failed: %s", e)
logger.info("✅ Request completed in %d ms", duration)
```

## Guidelines

- **Placement**: Put the emoji at the start of the message string so it appears in log aggregation and tail output.
- **One per message**: Use a single, clear emoji per log line; avoid multiple or decorative emojis.
- **Structured fields**: Keep emojis in the message; do not put them in structured fields (e.g. `error`, `context`) unless the logging format expects it.
- **Sensitive data**: Never log secrets or PII; emoji usage does not change existing security rules for log content.

---


# Security Best Practices

## Secret Management

### Never Hardcode Secrets

```typescript
// ❌ BAD
const apiKey = "sk_live_1234567890abcdef";
const password = "admin123";
const dbPassword = "mypassword";

// ✅ GOOD
const apiKey = process.env.API_KEY;
const password = process.env.ADMIN_PASSWORD;
const dbPassword = process.env.DB_PASSWORD;
```

### Secret Storage Guidelines

- **Use environment variables**: Store secrets in `.env` files (not committed)
- **Use secret management services**: AWS Secrets Manager, HashiCorp Vault, etc.
- **Never commit secrets**: Add `.env` to `.gitignore`
- **Rotate secrets regularly**: Update credentials periodically
- **Use different secrets per environment**: Dev, staging, production

### Environment Files

```bash
# .env (not committed)
API_KEY=your_secret_key
DB_PASSWORD=your_db_password
JWT_SECRET=your_jwt_secret

# .env.example (committed as template)
API_KEY=
DB_PASSWORD=
JWT_SECRET=
```

## Input Validation

### Validate All Inputs

```typescript
// ❌ BAD
function createUser(email: string, age: number) {
  // No validation - dangerous!
  db.users.create({ email, age });
}

// ✅ GOOD
function createUser(email: string, age: number): void {
  if (!isValidEmail(email)) {
    throw new ValidationError('Invalid email format');
  }
  if (age < 0 || age > 150) {
    throw new ValidationError('Invalid age');
  }
  db.users.create({ email, age });
}
```

### Validation Principles

- **Validate on the server**: Never trust client-side validation alone
- **Whitelist, don't blacklist**: Allow only known good values
- **Validate type and format**: Check data types and formats
- **Sanitize inputs**: Remove or escape dangerous characters
- **Validate length**: Prevent buffer overflows and DoS attacks

### Common Validation Patterns

```typescript
// Email validation
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
if (!emailRegex.test(email)) {
  throw new ValidationError('Invalid email');
}

// SQL injection prevention - use parameterized queries
// ❌ BAD
db.query(`SELECT * FROM users WHERE id = ${userId}`);

// ✅ GOOD
db.query('SELECT * FROM users WHERE id = ?', [userId]);

// XSS prevention - escape output
const safeHtml = escapeHtml(userInput);
```

## SQL Injection Prevention

### Use Parameterized Queries

```typescript
// ❌ BAD - SQL injection vulnerability
db.query(`SELECT * FROM users WHERE email = '${email}'`);

// ✅ GOOD - Parameterized query
db.query('SELECT * FROM users WHERE email = ?', [email]);

// ✅ GOOD - Using ORM
User.findOne({ where: { email } });
```

### ORM Best Practices

- Use ORM query builders instead of raw SQL
- Let ORM handle parameterization
- Validate inputs before database operations
- Use transactions for related operations

## XSS Prevention

### Escape User Input

```typescript
// ❌ BAD - XSS vulnerability
document.innerHTML = userComment;

// ✅ GOOD - Escape HTML
document.textContent = userComment;
// Or use a library
document.innerHTML = escapeHtml(userComment);
```

### Content Security Policy

Set appropriate CSP headers:

```
Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline'
```

## Authentication & Authorization

### Password Security

```typescript
// ❌ BAD - Plain text passwords
const password = req.body.password;
db.users.create({ password });

// ✅ GOOD - Hash passwords
import bcrypt from 'bcrypt';
const hashedPassword = await bcrypt.hash(password, 10);
db.users.create({ password: hashedPassword });
```

### Authentication Best Practices

- **Hash passwords**: Use bcrypt, argon2, or similar
- **Use strong algorithms**: Prefer bcrypt with cost factor 10+
- **Implement rate limiting**: Prevent brute force attacks
- **Use secure sessions**: HttpOnly, Secure cookies
- **Implement 2FA**: Two-factor authentication for sensitive operations

### Authorization Checks

```typescript
// ❌ BAD - No authorization check
function deleteUser(userId: string) {
  db.users.delete(userId);
}

// ✅ GOOD - Check permissions
function deleteUser(userId: string, requesterId: string): void {
  if (requesterId !== userId && !isAdmin(requesterId)) {
    throw new AuthorizationError('Not authorized');
  }
  db.users.delete(userId);
}
```

## Dependency Security

### Keep Dependencies Updated

```bash
# Check for vulnerabilities
npm audit
npm audit fix

# Update dependencies regularly
npm update

# Use dependency scanning tools
# Snyk, Dependabot, etc.
```

### Dependency Management

- **Review dependencies**: Understand what you're including
- **Use lock files**: Commit `package-lock.json` or `yarn.lock`
- **Pin critical dependencies**: Specify exact versions for security-critical packages
- **Remove unused dependencies**: Reduce attack surface
- **Monitor for vulnerabilities**: Set up automated scanning

## HTTPS & TLS

- **Always use HTTPS**: Never transmit sensitive data over HTTP
- **Use strong TLS versions**: TLS 1.2 minimum, prefer TLS 1.3
- **Validate certificates**: Verify SSL certificates
- **Use secure headers**: HSTS, CSP, etc.

## Error Handling Security

### Don't Expose Sensitive Information

```typescript
// ❌ BAD - Exposes internal details
catch (error) {
  res.status(500).json({ 
    error: error.message,
    stack: error.stack,
    sql: error.sql 
  });
}

// ✅ GOOD - Generic error messages
catch (error) {
  logger.error('Database error', { error, userId });
  res.status(500).json({ 
    error: 'An error occurred. Please try again later.' 
  });
}
```

### Secure Error Handling

- **Log errors securely**: Include context in logs, not responses
- **Use generic messages**: Don't reveal system internals
- **Handle errors gracefully**: Don't crash on errors
- **Monitor error logs**: Track security-related errors

## Common Vulnerabilities

### OWASP Top 10 Awareness

1. **Broken Access Control**: Always verify permissions
2. **Cryptographic Failures**: Use strong encryption
3. **Injection**: Validate and sanitize inputs
4. **Insecure Design**: Design with security in mind
5. **Security Misconfiguration**: Secure default configurations
6. **Vulnerable Components**: Keep dependencies updated
7. **Authentication Failures**: Implement strong auth
8. **Software and Data Integrity**: Verify integrity
9. **Security Logging Failures**: Log security events
10. **SSRF**: Validate and restrict server requests

## Security Checklist

- [ ] No secrets in code or committed files
- [ ] All inputs validated and sanitized
- [ ] Parameterized queries used for databases
- [ ] Passwords hashed with strong algorithms
- [ ] HTTPS used for all connections
- [ ] Dependencies updated and scanned
- [ ] Error messages don't expose sensitive info
- [ ] Authentication and authorization implemented
- [ ] Security headers configured
- [ ] Regular security audits performed
