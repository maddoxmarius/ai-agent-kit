---
description: Dedalus git commit conventions including Conventional Commits format with ticket number requirements (HDEFECT/HFW)
alwaysApply: true
ruleSet: dedalus
---

# Git Commit Instructions (Conventional Commits)

## Commit Message Format

Structure:
```
<type>(<scope>): <description> [<TICKET-NUMBER> /fixed]

[optional body]

[optional footer(s)]
```

## Types

- **feat**: a new feature
- **fix**: a bug fix
- **docs**: documentation only changes
- **style**: changes that do not affect the meaning of the code (formatting, missing semicolons, etc.)
- **refactor**: a code change that neither fixes a bug nor adds a feature
- **perf**: a code change that improves performance
- **test**: adding missing tests or correcting existing tests
- **build**: changes that affect the build system or external dependencies (Maven, npm, yarn)
- **ci**: changes to CI configuration files and scripts
- **chore**: other changes that don't modify src or test files

## Ticket Number

Always include the ticket number from your branch name:
- For HDEFECT tickets: `[HDEFECT-12345 /fixed]`
- For HFW tickets: `[HFW-5460 /fixed]`

### Extracting Ticket Number from Branch Name

Example branch name:
```
HFW-5460_provide_ORBIS_U_Platform_Metadata  ->  HFW-5460
```

Extract the ticket prefix and number from the beginning of the branch name.

## Examples

```bash
feat(api): add user authentication endpoint [HFW-5460 /fixed]

fix(ui): resolve null pointer exception in user profile [HDEFECT-789 /fixed]

docs(readme): update installation instructions [HFW-5460 /fixed]

refactor(service): simplify data validation logic [HFW-5460 /fixed]
```

## Guidelines

- Use the imperative mood in the description ("add" not "added")
- Don't capitalize the first letter of the description
- No period at the end of the description
- Keep the first line under 72 characters
- Add detailed explanation in the body if needed
- Reference breaking changes in the footer with:
  ```
  BREAKING CHANGE: <description>
  ```

## Complete Example

```
feat(auth): implement JWT token validation [HFW-5460 /fixed]

Add POST /api/auth/login endpoint with JWT token generation.
Includes input validation and error handling.

BREAKING CHANGE: Authentication now requires API key in header.
```

## Branch Naming

Follow Dedalus branch naming conventions:
- Feature branches: `HFW-<number>_<description>` or `HDEFECT-<number>_<description>`
- Use kebab-case for description: `HFW-5460_provide_platform_metadata`
- Extract ticket number from branch name for commit messages
