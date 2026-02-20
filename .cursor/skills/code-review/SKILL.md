---
name: code-review
description: Review code for quality, security, and maintainability following universal best practices. Use when reviewing pull requests, examining code changes, or when the user asks for a code review.
---

# Code Review

## Quick Start

When reviewing code, check for:
1. Correctness and potential bugs
2. Security vulnerabilities
3. Code readability and maintainability
4. Test coverage and quality
5. Adherence to project conventions

## Review Checklist

### Functionality
- [ ] Code works as intended
- [ ] Edge cases are handled
- [ ] Error handling is comprehensive
- [ ] No obvious bugs or logic errors
- [ ] Performance considerations addressed

### Security
- [ ] No hardcoded secrets or credentials
- [ ] Input validation implemented
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (output escaping)
- [ ] Authentication/authorization checks present
- [ ] Dependencies are secure and up-to-date

### Code Quality
- [ ] Follows project style guidelines
- [ ] Functions are appropriately sized and focused
- [ ] Naming is clear and descriptive
- [ ] No code duplication
- [ ] Complexity is reasonable
- [ ] Comments explain "why" not "what"

### Testing
- [ ] Tests cover new functionality
- [ ] Edge cases are tested
- [ ] Tests are clear and maintainable
- [ ] Test coverage is adequate
- [ ] Integration tests where needed

### Documentation
- [ ] Code is self-documenting
- [ ] Complex logic has comments
- [ ] README/docs updated if needed
- [ ] API changes documented

## Review Format

Structure feedback as:

### Critical Issues (Must Fix)
- Security vulnerabilities
- Bugs that break functionality
- Performance issues
- Breaking changes without migration

### Suggestions (Should Fix)
- Code quality improvements
- Better error handling
- Missing tests
- Documentation gaps

### Nice to Have (Optional)
- Code style preferences
- Minor optimizations
- Additional test cases
- Documentation enhancements

## Common Issues to Look For

### Security
- Hardcoded secrets
- Missing input validation
- SQL injection vulnerabilities
- XSS vulnerabilities
- Missing authorization checks
- Insecure dependencies

### Code Quality
- Functions too long or complex
- Poor naming conventions
- Code duplication
- Magic numbers/strings
- Missing error handling
- Dead code

### Testing
- Missing test coverage
- Tests don't test the right things
- Flaky tests
- Missing edge case tests
- Tests are hard to understand

## Providing Constructive Feedback

- **Be specific**: Point to exact lines or functions
- **Be kind**: Focus on code, not the person
- **Explain why**: Help the author understand the concern
- **Suggest solutions**: Offer concrete improvements
- **Prioritize**: Focus on important issues first

## Example Review Comments

### Good Feedback
```
The error handling in `processPayment()` doesn't handle network timeouts.
Consider adding a retry mechanism with exponential backoff.

See: https://example.com/retry-pattern
```

### Less Helpful Feedback
```
This is wrong.
```

## Review Best Practices

- **Review promptly**: Don't let PRs sit for days
- **Be thorough**: Check all aspects, not just functionality
- **Ask questions**: If something is unclear, ask
- **Approve when ready**: Don't block on minor issues
- **Learn from reviews**: Use feedback to improve your own code
