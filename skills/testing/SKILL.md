---
name: testing
description: Write comprehensive tests following best practices including test structure, coverage guidelines, and test naming conventions. Use when writing tests, improving test coverage, or reviewing test code.
---

# Testing Best Practices

## Test Structure

### Arrange-Act-Assert Pattern

```typescript
describe('UserService', () => {
  describe('createUser', () => {
    it('should create a new user with valid data', () => {
      // Arrange
      const userData = {
        email: 'test@example.com',
        name: 'Test User',
        password: 'securepassword'
      };
      const mockRepository = createMockRepository();
      
      // Act
      const result = userService.createUser(userData, mockRepository);
      
      // Assert
      expect(result.email).toBe(userData.email);
      expect(mockRepository.save).toHaveBeenCalledWith(
        expect.objectContaining({ email: userData.email })
      );
    });
  });
});
```

### Test Organization

- **Group related tests**: Use `describe` blocks to organize
- **One concept per test**: Each test should verify one thing
- **Clear test names**: Test names should describe what is being tested
- **Setup and teardown**: Use `beforeEach`/`afterEach` for common setup

## Test Naming Conventions

### Descriptive Names

```typescript
// ✅ GOOD - Clear and descriptive
it('should throw ValidationError when email is invalid', () => {});
it('should return user when valid ID is provided', () => {});
it('should update user email and return updated user', () => {});

// ❌ BAD - Vague
it('test user', () => {});
it('works', () => {});
it('test1', () => {});
```

### Naming Pattern

Use format: `should [expected behavior] when [condition]`

```typescript
it('should return empty array when no users exist', () => {});
it('should throw error when user ID is null', () => {});
it('should filter users by active status when filter is provided', () => {});
```

## Test Coverage Guidelines

### What to Test

- **Happy paths**: Normal, expected behavior
- **Edge cases**: Boundary conditions, empty inputs, null values
- **Error cases**: Invalid inputs, failure scenarios
- **Business logic**: Complex calculations, validations
- **Integration points**: API calls, database operations

### Coverage Targets

- **Critical paths**: Aim for 90%+ coverage
- **Business logic**: 100% coverage
- **Utilities**: 80%+ coverage
- **UI components**: Focus on user interactions
- **Overall**: 70-80% is reasonable for most projects

### What Not to Test

- **Framework code**: Don't test React, Express, etc.
- **Third-party libraries**: Don't test external dependencies
- **Trivial code**: Simple getters/setters may not need tests
- **Implementation details**: Test behavior, not internals

## Unit Tests

### Characteristics

- **Fast**: Run in milliseconds
- **Isolated**: Don't depend on external systems
- **Deterministic**: Same input always produces same output
- **Focused**: Test one unit of code

### Example

```typescript
describe('calculateTotal', () => {
  it('should calculate total with tax', () => {
    const result = calculateTotal(100, 0.08);
    expect(result).toBe(108);
  });
  
  it('should handle zero tax rate', () => {
    const result = calculateTotal(100, 0);
    expect(result).toBe(100);
  });
  
  it('should throw error for negative price', () => {
    expect(() => calculateTotal(-100, 0.08))
      .toThrow('Price cannot be negative');
  });
});
```

## Integration Tests

### Characteristics

- **Test interactions**: Verify components work together
- **Use real dependencies**: May use test database, mock APIs
- **Slower**: May take seconds to run
- **More realistic**: Closer to production environment

### Example

```typescript
describe('User API Integration', () => {
  beforeEach(async () => {
    await setupTestDatabase();
  });
  
  afterEach(async () => {
    await cleanupTestDatabase();
  });
  
  it('should create and retrieve user', async () => {
    const userData = { email: 'test@example.com', name: 'Test' };
    
    const createResponse = await request(app)
      .post('/api/users')
      .send(userData)
      .expect(201);
    
    const userId = createResponse.body.id;
    
    const getResponse = await request(app)
      .get(`/api/users/${userId}`)
      .expect(200);
    
    expect(getResponse.body.email).toBe(userData.email);
  });
});
```

## Test Best Practices

### Keep Tests Simple

```typescript
// ✅ GOOD - Simple and clear
it('should return user by ID', async () => {
  const user = await userService.getUserById('123');
  expect(user.id).toBe('123');
});

// ❌ BAD - Too complex
it('should work', async () => {
  const user = await userService.getUserById('123');
  if (user) {
    expect(user.id).toBe('123');
    if (user.email) {
      expect(user.email).toContain('@');
    }
  }
});
```

### Use Mocks Appropriately

```typescript
// ✅ GOOD - Mock external dependencies
const mockDatabase = {
  findById: jest.fn().mockResolvedValue({ id: '123', name: 'Test' })
};

// ❌ BAD - Don't mock what you're testing
const mockCalculateTotal = jest.fn();
```

### Test Behavior, Not Implementation

```typescript
// ✅ GOOD - Test behavior
it('should return sorted users', () => {
  const users = userService.getUsersSorted();
  expect(users[0].name).toBe('Alice');
  expect(users[1].name).toBe('Bob');
});

// ❌ BAD - Test implementation details
it('should call sort function', () => {
  const sortSpy = jest.spyOn(Array.prototype, 'sort');
  userService.getUsersSorted();
  expect(sortSpy).toHaveBeenCalled();
});
```

### Clean Up After Tests

```typescript
describe('Database Tests', () => {
  beforeEach(async () => {
    await setupTestData();
  });
  
  afterEach(async () => {
    await cleanupTestData(); // Important!
  });
  
  // Tests...
});
```

## Common Testing Patterns

### Testing Async Code

```typescript
it('should fetch user data', async () => {
  const user = await userService.getUser('123');
  expect(user).toBeDefined();
});

it('should handle fetch errors', async () => {
  await expect(userService.getUser('invalid'))
    .rejects
    .toThrow('User not found');
});
```

### Testing Error Cases

```typescript
it('should throw ValidationError for invalid email', () => {
  expect(() => validateEmail('invalid'))
    .toThrow(ValidationError);
});

it('should throw NotFoundError when user does not exist', async () => {
  await expect(userService.getUser('999'))
    .rejects
    .toThrow(NotFoundError);
});
```

### Testing Edge Cases

```typescript
it('should handle empty array', () => {
  const result = processUsers([]);
  expect(result).toEqual([]);
});

it('should handle null input', () => {
  expect(() => processUser(null))
    .toThrow('User cannot be null');
});

it('should handle very large numbers', () => {
  const result = calculateTotal(Number.MAX_SAFE_INTEGER, 0.1);
  expect(result).toBeGreaterThan(0);
});
```

## Test Checklist

- [ ] Tests have descriptive names
- [ ] Tests follow Arrange-Act-Assert pattern
- [ ] Tests are isolated and independent
- [ ] Edge cases are covered
- [ ] Error cases are tested
- [ ] Tests clean up after themselves
- [ ] Mocks are used appropriately
- [ ] Tests are fast and reliable
- [ ] Test coverage is adequate
- [ ] Tests verify behavior, not implementation
