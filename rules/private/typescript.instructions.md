# TypeScript Instructions

These instructions apply when working with TypeScript files (`**/*.ts`, `**/*.tsx`).

## Type Safety

### Use TypeScript Types

- Always define types for function parameters and return values
- Use interfaces for object shapes
- Prefer `interface` for object types, `type` for unions/intersections
- Avoid `any` - use `unknown` when type is truly unknown
- Use type guards for runtime type checking

```typescript
// ✅ GOOD
interface User {
  id: string;
  email: string;
  name: string;
}

function getUser(id: string): Promise<User> {
  return fetch(`/api/users/${id}`).then(res => res.json());
}

// ❌ BAD
function getUser(id: any): any {
  return fetch(`/api/users/${id}`).then(res => res.json());
}
```

### Type Inference

- Let TypeScript infer types when obvious
- Explicitly type function signatures and public APIs
- Use `const` assertions for literal types
- Leverage type inference for local variables

```typescript
// ✅ GOOD - Type inferred
const users = ['alice', 'bob', 'charlie'];

// ✅ GOOD - Explicit type for function
function processUsers(users: string[]): void {
  // Implementation
}

// ✅ GOOD - Const assertion
const status = 'active' as const;
```

## Modern TypeScript Features

### Use Modern Syntax

- Prefer `async/await` over promises
- Use optional chaining (`?.`) and nullish coalescing (`??`)
- Use template literals for string interpolation
- Prefer arrow functions for callbacks
- Use destructuring for object/array access

```typescript
// ✅ GOOD
const email = user?.email ?? 'no-email';
const fullName = `${user.firstName} ${user.lastName}`;
const { id, name } = user;

// ❌ BAD
const email = user && user.email ? user.email : 'no-email';
const fullName = user.firstName + ' ' + user.lastName;
const id = user.id;
const name = user.name;
```

### Enums and Unions

- Prefer union types over enums when possible
- Use `const` enums for better performance
- Use string literal unions for fixed sets of values

```typescript
// ✅ GOOD - Union type
type Status = 'pending' | 'approved' | 'rejected';

// ✅ GOOD - Const enum
const enum Status {
  Pending = 'pending',
  Approved = 'approved',
  Rejected = 'rejected'
}
```

## Error Handling

### Type-Safe Error Handling

- Create custom error classes extending `Error`
- Use type guards to narrow error types
- Handle errors with proper typing

```typescript
class ValidationError extends Error {
  constructor(message: string, public field: string) {
    super(message);
    this.name = 'ValidationError';
  }
}

function isValidationError(error: unknown): error is ValidationError {
  return error instanceof ValidationError;
}

try {
  validateUser(user);
} catch (error) {
  if (isValidationError(error)) {
    console.error(`Validation failed for ${error.field}`);
  } else {
    throw error;
  }
}
```

## Code Organization

### Imports and Exports

- Use named exports for utilities and functions
- Use default exports sparingly (mainly for components)
- Group imports: external, internal, types
- Use type-only imports when appropriate

```typescript
// ✅ GOOD
import { useState, useEffect } from 'react';
import { UserService } from './services/UserService';
import type { User } from './types/User';

// ❌ BAD
import * as React from 'react';
import UserService from './services/UserService';
```

### File Organization

- One main export per file
- Group related code together
- Separate types into type files when reused
- Use index files for public API

## TypeScript-Specific Patterns

### Generics

- Use generics for reusable, type-safe code
- Provide constraints when needed
- Use descriptive generic names (`T`, `K`, `V` for simple cases)

```typescript
// ✅ GOOD
function getById<T extends { id: string }>(items: T[], id: string): T | undefined {
  return items.find(item => item.id === id);
}

// Usage
const user = getById(users, '123');
const product = getById(products, '456');
```

### Utility Types

- Leverage TypeScript utility types (`Partial`, `Pick`, `Omit`, `Record`)
- Create custom utility types when needed
- Use mapped types for transformations

```typescript
// ✅ GOOD
type UserUpdate = Partial<Pick<User, 'email' | 'name'>>;
type UserMap = Record<string, User>;
```

## Best Practices

- Enable strict mode in `tsconfig.json`
- Use `strictNullChecks` and `noImplicitAny`
- Avoid type assertions unless necessary
- Use `as const` for immutable data
- Prefer interfaces for object shapes that may be extended
- Use type aliases for unions, intersections, and complex types
