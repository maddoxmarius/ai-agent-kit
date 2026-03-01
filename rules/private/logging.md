---
description: Use emojis in log messages to improve scanability and quick identification of log level or intent
alwaysApply: true
ruleSet: private
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
