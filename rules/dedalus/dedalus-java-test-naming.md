---
description: Dedalus Java test method naming - name tests methodUnderTest_testCase
globs: "**/*Test.java"
alwaysApply: false
ruleSet: dedalus
---

# Java Test Method Naming

Name every test method `testMethod_testCase`, where `testMethod` is the method
or behavior under test and `testCase` describes the scenario or expected
outcome. Use lowerCamelCase for both parts, separated by a single underscore.

## Rules

- Use exactly one underscore: `<methodUnderTest>_<testCase>`.
- `methodUnderTest` matches the production method name (or behavior) being tested.
- `testCase` states the condition and/or expected result, in lowerCamelCase.
- Do not prefix with `test` (the framework no longer needs it) and do not use
  underscores elsewhere in the name.

## Examples

```java
// ❌ BAD
@Test
void testGetLicense() { }

@Test
void licenseIsNullWhenServiceUnavailable() { }

@Test
void getLicense_returns_null_when_service_unavailable() { }
```

```java
// ✅ GOOD
@Test
void getLicense_returnsLicenseWhenServiceAvailable() { }

@Test
void getLicense_returnsNullWhenServiceUnavailable() { }

@Test
void resolveEndpoint_throwsWhenUriMissing() { }
```
