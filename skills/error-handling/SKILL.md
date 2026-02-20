---
name: error-handling
description: Implement comprehensive error handling patterns including exception handling, error logging, and user-facing error messages. Use when writing error handling code, debugging error scenarios, or improving error handling in existing code.
---

# Error Handling

## Core Principles

1. **Handle errors explicitly**: Never ignore or silently catch errors
2. **Fail fast**: Detect invalid states early
3. **Provide context**: Include relevant information in errors
4. **Log appropriately**: Log errors with sufficient context
5. **User-friendly messages**: Show helpful messages to users

## Error Handling Patterns

### Try-Catch Blocks

```typescript
// ❌ BAD - Empty catch block
try {
  await processData();
} catch (error) {}

// ✅ GOOD - Handle and log
try {
  await processData();
} catch (error) {
  logger.error('Failed to process data', { error, context });
  throw new ProcessingError('Unable to process data', { cause: error });
}

// ✅ GOOD - Handle gracefully with fallback
try {
  const data = await fetchData();
  return data;
} catch (error) {
  logger.warn('Failed to fetch data, using cache', { error });
  return getCachedData();
}
```

### Error Types

Create specific error types for different failure modes:

```typescript
// Custom error classes
class ValidationError extends Error {
  constructor(message: string, public field: string) {
    super(message);
    this.name = 'ValidationError';
  }
}

class NotFoundError extends Error {
  constructor(message: string, public resource: string) {
    super(message);
    this.name = 'NotFoundError';
  }
}

class AuthenticationError extends Error {
  constructor(message: string = 'Authentication failed') {
    super(message);
    this.name = 'AuthenticationError';
  }
}

// Usage
if (!isValidEmail(email)) {
  throw new ValidationError('Invalid email format', 'email');
}

if (!user) {
  throw new NotFoundError('User not found', 'user');
}
```

### Error Propagation

```typescript
// ✅ GOOD - Propagate with context
async function processUser(userId: string): Promise<User> {
  try {
    const user = await getUser(userId);
    return await processUserData(user);
  } catch (error) {
    if (error instanceof NotFoundError) {
      throw error; // Re-throw known errors
    }
    throw new ProcessingError('Failed to process user', { 
      cause: error,
      userId 
    });
  }
}
```

## Error Logging

### Log with Context

```typescript
// ❌ BAD - No context
catch (error) {
  logger.error(error);
}

// ✅ GOOD - Include context
catch (error) {
  logger.error('Failed to process payment', {
    error: error.message,
    userId: user.id,
    amount: payment.amount,
    paymentId: payment.id,
    stack: error.stack
  });
}
```

### Log Levels

- **Error**: Unexpected errors that need attention
- **Warn**: Recoverable issues or deprecations
- **Info**: Important events (user actions, system events)
- **Debug**: Detailed information for debugging

```typescript
logger.error('Database connection failed', { error });
logger.warn('Using deprecated API endpoint', { endpoint });
logger.info('User logged in', { userId });
logger.debug('Processing request', { requestId, headers });
```

## User-Facing Error Messages

### Generic but Helpful

```typescript
// ❌ BAD - Exposes internal details
catch (error) {
  res.status(500).json({
    error: `Database error: ${error.message}`,
    sql: error.sql,
    stack: error.stack
  });
}

// ✅ GOOD - User-friendly message
catch (error) {
  logger.error('Database error', { error, userId, requestId });
  res.status(500).json({
    error: 'An error occurred processing your request. Please try again later.',
    requestId: requestId // For support reference
  });
}
```

### Validation Errors

```typescript
// ✅ GOOD - Specific validation errors
try {
  validateUserInput(data);
} catch (error) {
  if (error instanceof ValidationError) {
    res.status(400).json({
      error: 'Validation failed',
      fields: error.fields // Specific field errors
    });
  } else {
    throw error;
  }
}
```

## Error Handling in Async Code

### Promises

```typescript
// ✅ GOOD - Handle promise rejections
async function fetchUserData(userId: string): Promise<UserData> {
  return fetch(`/api/users/${userId}`)
    .then(response => {
      if (!response.ok) {
        throw new HttpError(`HTTP ${response.status}`, response.status);
      }
      return response.json();
    })
    .catch(error => {
      logger.error('Failed to fetch user data', { userId, error });
      throw new DataFetchError('Unable to retrieve user data', { cause: error });
    });
}
```

### Async/Await

```typescript
// ✅ GOOD - Try-catch with async/await
async function processOrder(orderId: string): Promise<Order> {
  try {
    const order = await getOrder(orderId);
    if (!order) {
      throw new NotFoundError('Order not found', 'order');
    }
    
    await validateOrder(order);
    await processPayment(order);
    await updateInventory(order);
    
    return order;
  } catch (error) {
    if (error instanceof ValidationError) {
      logger.warn('Order validation failed', { orderId, error });
      throw error;
    }
    logger.error('Failed to process order', { orderId, error });
    throw new OrderProcessingError('Unable to process order', { cause: error });
  }
}
```

## Error Recovery Strategies

### Retry Logic

```typescript
async function fetchWithRetry(url: string, maxRetries = 3): Promise<Response> {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await fetch(url);
    } catch (error) {
      if (attempt === maxRetries) {
        throw new FetchError('Max retries exceeded', { cause: error });
      }
      await sleep(1000 * attempt); // Exponential backoff
      logger.warn(`Retry attempt ${attempt}`, { url, error });
    }
  }
  throw new Error('Unreachable');
}
```

### Fallback Values

```typescript
async function getConfiguration(): Promise<Config> {
  try {
    return await fetchConfigFromAPI();
  } catch (error) {
    logger.warn('Failed to fetch config, using defaults', { error });
    return getDefaultConfiguration();
  }
}
```

## Error Handling Checklist

- [ ] All potential errors are handled
- [ ] Error messages are user-friendly
- [ ] Errors are logged with context
- [ ] Specific error types are used
- [ ] Errors propagate with context
- [ ] Recovery strategies are implemented where appropriate
- [ ] No empty catch blocks
- [ ] Error handling doesn't expose sensitive information

## Common Patterns

### Validation Errors
```typescript
if (!isValid(input)) {
  throw new ValidationError('Invalid input', { field: 'input' });
}
```

### Not Found Errors
```typescript
const user = await getUser(id);
if (!user) {
  throw new NotFoundError('User not found', 'user');
}
```

### Permission Errors
```typescript
if (!hasPermission(user, 'delete', resource)) {
  throw new AuthorizationError('Insufficient permissions');
}
```

### Network Errors
```typescript
try {
  await fetch(url);
} catch (error) {
  if (error instanceof NetworkError) {
    // Handle network issues
  }
  throw error;
}
```
