# Security Instructions

These instructions apply when writing code that handles sensitive data, user input, authentication, or any security-critical functionality.

## Secret Management

### Never Hardcode Secrets

```python
# ❌ BAD
API_KEY = "sk_live_1234567890abcdef"
DATABASE_PASSWORD = "mypassword"

# ✅ GOOD
import os
API_KEY = os.getenv("API_KEY")
DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD")
```

```typescript
// ❌ BAD
const apiKey = "sk_live_1234567890abcdef";

// ✅ GOOD
const apiKey = process.env.API_KEY;
```

### Environment Variables

- Store secrets in environment variables
- Use `.env` files for local development (not committed)
- Use secret management services in production
- Never commit secrets to version control
- Rotate secrets regularly

## Input Validation

### Validate All Inputs

- Validate data types, formats, and ranges
- Sanitize user input before processing
- Use whitelist validation (allow known good values)
- Validate on the server side (never trust client-side validation alone)

```python
# ✅ GOOD
def create_user(email: str, age: int) -> User:
    if not re.match(r'^[^\s@]+@[^\s@]+\.[^\s@]+$', email):
        raise ValidationError("Invalid email format")
    if age < 0 or age > 150:
        raise ValidationError("Invalid age")
    return User(email=email, age=age)
```

```typescript
// ✅ GOOD
function createUser(email: string, age: number): User {
  if (!isValidEmail(email)) {
    throw new ValidationError('Invalid email format');
  }
  if (age < 0 || age > 150) {
    throw new ValidationError('Invalid age');
  }
  return new User(email, age);
}
```

## SQL Injection Prevention

### Use Parameterized Queries

```python
# ❌ BAD - SQL injection vulnerability
cursor.execute(f"SELECT * FROM users WHERE email = '{email}'")

# ✅ GOOD - Parameterized query
cursor.execute("SELECT * FROM users WHERE email = ?", (email,))
# Or with psycopg2
cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
```

```typescript
// ❌ BAD - SQL injection vulnerability
db.query(`SELECT * FROM users WHERE email = '${email}'`);

// ✅ GOOD - Parameterized query
db.query('SELECT * FROM users WHERE email = ?', [email]);
```

### ORM Best Practices

- Use ORM query builders instead of raw SQL
- Let ORM handle parameterization
- Validate inputs before database operations

## XSS Prevention

### Escape Output

```python
# ✅ GOOD - Escape HTML
from html import escape

def render_comment(comment: str) -> str:
    return escape(comment)
```

```typescript
// ✅ GOOD - Escape HTML
function renderComment(comment: string): string {
  return escapeHtml(comment);
  // Or use textContent instead of innerHTML
  element.textContent = comment;
}
```

## Authentication & Authorization

### Password Security

```python
# ✅ GOOD - Hash passwords
import bcrypt

def create_user(email: str, password: str) -> User:
    hashed_password = bcrypt.hashpw(password.encode(), bcrypt.gensalt())
    return User(email=email, password=hashed_password)

def verify_password(password: str, hashed: str) -> bool:
    return bcrypt.checkpw(password.encode(), hashed.encode())
```

```typescript
// ✅ GOOD - Hash passwords
import bcrypt from 'bcrypt';

async function createUser(email: string, password: string): Promise<User> {
  const hashedPassword = await bcrypt.hash(password, 10);
  return new User(email, hashedPassword);
}
```

### Authorization Checks

- Always verify permissions before sensitive operations
- Check user roles and permissions
- Implement principle of least privilege
- Don't trust client-side authorization checks

```python
# ✅ GOOD
def delete_user(user_id: str, requester_id: str) -> None:
    if requester_id != user_id and not is_admin(requester_id):
        raise AuthorizationError("Not authorized")
    db.delete_user(user_id)
```

## Dependency Security

### Keep Dependencies Updated

- Regularly update dependencies
- Use dependency scanning tools (Snyk, Dependabot)
- Review security advisories
- Pin critical dependencies to specific versions
- Remove unused dependencies

```bash
# Check for vulnerabilities
npm audit
pip-audit

# Update dependencies
npm update
pip install --upgrade package-name
```

## Error Handling Security

### Don't Expose Sensitive Information

```python
# ❌ BAD - Exposes internal details
try:
    process_payment()
except Exception as e:
    return {"error": str(e), "stack": traceback.format_exc()}

# ✅ GOOD - Generic error message
try:
    process_payment()
except Exception as e:
    logger.error("Payment processing failed", exc_info=True)
    return {"error": "An error occurred. Please try again later."}
```

## HTTPS & TLS

- Always use HTTPS for production
- Use strong TLS versions (TLS 1.2 minimum, prefer 1.3)
- Validate SSL certificates
- Use secure headers (HSTS, CSP, etc.)

## Security Checklist

When writing security-critical code:

- [ ] No secrets hardcoded in code
- [ ] All inputs validated and sanitized
- [ ] Parameterized queries used for databases
- [ ] Passwords hashed with strong algorithms
- [ ] HTTPS used for all connections
- [ ] Dependencies updated and scanned
- [ ] Error messages don't expose sensitive info
- [ ] Authentication and authorization implemented
- [ ] Security headers configured
- [ ] Rate limiting implemented where needed
