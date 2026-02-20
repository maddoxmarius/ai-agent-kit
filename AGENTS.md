# Agent Instructions

This file provides agent-specific instructions for AI coding assistants. These instructions apply to all agents that support this format (Claude, Gemini, etc.).

## Core Principles

### Code Quality
- Write clean, maintainable code following best practices
- Prefer explicit over implicit
- Use meaningful names for variables, functions, and classes
- Keep functions focused and single-purpose
- Handle errors explicitly and gracefully

### Security
- Never hardcode secrets, API keys, or credentials
- Validate and sanitize all user inputs
- Use parameterized queries for database operations
- Follow principle of least privilege
- Keep dependencies updated and scan for vulnerabilities

### Documentation
- Write self-documenting code with clear naming
- Add comments only when necessary to explain "why", not "what"
- Keep README files up-to-date with setup and usage instructions
- Document public APIs and interfaces
- Include examples for complex functionality

### Testing
- Write tests for critical functionality
- Aim for reasonable test coverage
- Use descriptive test names that explain what is being tested
- Keep tests independent and isolated
- Test edge cases and error conditions

## Workflow Guidelines

### Code Review
- Review for correctness, security, and maintainability
- Check that error handling is comprehensive
- Verify tests are adequate
- Ensure code follows project conventions
- Provide constructive, actionable feedback

### Commit Messages
- Use conventional commit format: `type(scope): description`
- Types: feat, fix, docs, style, refactor, test, chore
- Write clear, concise descriptions
- Include context in body when necessary
- Reference issues when applicable

### Error Handling
- Always handle potential errors explicitly
- Provide meaningful error messages
- Log errors with appropriate context
- Fail fast when encountering invalid states
- Use appropriate error types/exceptions

### Git Workflow
- Use descriptive branch names: `feature/`, `fix/`, `docs/`
- Keep commits focused and atomic
- Write clear commit messages
- Review changes before committing
- Keep main/master branch stable

## Language-Specific Guidelines

### TypeScript/JavaScript
- Use TypeScript for type safety
- Prefer `const` over `let`, avoid `var`
- Use async/await over promises
- Handle null/undefined explicitly
- Use modern ES6+ features appropriately

### Python
- Follow PEP 8 style guide
- Use type hints for function signatures
- Prefer f-strings for string formatting
- Use virtual environments for dependencies
- Handle exceptions explicitly

### General
- Follow language-specific style guides
- Use linters and formatters
- Keep dependencies minimal and up-to-date
- Document complex algorithms and decisions
- Write code that is easy to understand and maintain

## When to Ask Questions

- When requirements are ambiguous or unclear
- When multiple valid approaches exist and context is needed
- When security implications need clarification
- When performance requirements are not specified
- When integration points are unclear

## Anti-Patterns to Avoid

- Don't ignore errors or use empty catch blocks
- Don't commit commented-out code
- Don't use magic numbers or strings
- Don't create overly complex abstractions
- Don't skip error handling for "simple" operations
- Don't hardcode configuration values
- Don't write code without tests for critical paths
