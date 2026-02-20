---
description: Universal code quality standards including error handling, code organization, naming conventions, and complexity guidelines
alwaysApply: true
ruleSet: private
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
