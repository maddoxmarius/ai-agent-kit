# Dedalus Java Coding Instructions

These instructions apply when writing Java code (`**/*.java`).

## Style Guide

Follow the [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html) with these Dedalus-specific deviations:

- **Indentation**: 4 spaces (not 2)
- **Column limit**: 120 characters
- **Continuation lines**: indent at least 8 spaces (2× block indent)
- **Blank lines**: multiple consecutive blank lines are not permitted
- **Switch blocks**: contents indented +4 (same as any other block)
- **Annotations**: do not place annotations on the same line as a property declaration

## File Header

Every Java source file must start with the DH copyright header:

```java
/*
 *                C O P Y R I G H T  (c) 2022
 *                        DEDALUS SPA
 *                    All Rights Reserved
 *
 *
 *      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF
 *                        DEDALUS SPA
 *     The copyright notice above does not evidence any
 *    actual or intended publication of such source code.
 */
```

## Logging

- Use **SLF4J** as the logging interface — never `System.out`, `System.err`, or a concrete framework directly.
- Cache logger objects in a `private static final` field:
  ```java
  private static final Logger LOG = LoggerFactory.getLogger(MyClass.class);
  ```
- Use **parameterized log messages** — never string concatenation:
  ```java
  // ✅ GOOD
  LOG.debug("Processing report {}", report);

  // ❌ BAD
  LOG.debug("Processing report " + report);
  ```
- Guard expensive log construction with a level check:
  ```java
  if (LOG.isDebugEnabled()) {
      LOG.debug("State: {}", expensiveToString());
  }
- Only log **technical exceptions** at `ERROR` or `WARN`. User-facing conditions (e.g. validation failures) belong at `DEBUG` or `INFO`.
- Do **not** log and rethrow the same exception — log it once, at the point where it is handled.
- Log levels:
  | Level   | When to use |
  |---------|-------------|
  | `ERROR` | Severe technical failure; application may still continue |
  | `WARN`  | Potentially harmful situation; application continues |
  | `INFO`  | Key milestones (production-safe) |
  | `DEBUG` | Fine-grained detail for developers only |
  | `TRACE` | Execution flow tracing; use sparingly — avoid in getters/setters |

## Exception Handling

- Throw exceptions only for **abnormal conditions** the method cannot handle — not for expected control flow.
- Always include a descriptive message:
  ```java
  throw new IllegalArgumentException("facilityId must not be null");
  ```
- When wrapping a lower-level exception, always pass it as the **cause**:
  ```java
  catch (SQLException e) {
      throw new ResourceLoadException("Could not load resource: " + name, e);
  }
  ```
- Prefer **specific exception types** over broad catches (`catch (Exception e)` is a last resort).
- Group related exceptions into a hierarchy; declare only the parent in `throws` clauses to keep signatures stable.
- Do **not** use unchecked exceptions just to avoid declaring `throws`.
- Do **not** use Java `assert` on public methods — use `NullPointerException` / `IllegalArgumentException` explicitly instead.
- Do not throw more than ~3 distinct exception types from a single method; if you do, the method likely does too much.
- Preserve exception causes — never swallow or discard the original stack trace.

## General Best Practices

- Validate arguments of public methods unconditionally (not guarded by a flag or assert).
- Write log messages that read like a story — the primary audience is Global Service (GSC/GSN), not developers.
- Pass only **immutable** objects to logger calls to avoid race conditions with async logging.
- Do not cache log-level checks (e.g. the result of `isDebugEnabled()`) — levels can change at runtime.
