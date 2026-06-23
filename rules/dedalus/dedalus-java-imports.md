---
description: Dedalus Java import ordering and import conventions (from IntelliJ .editorconfig)
globs: "**/*.java"
alwaysApply: false
ruleSet: dedalus
---

# Java Import Ordering

Order imports in every `.java` file to match the IntelliJ `ij_java_imports_layout`.
A `|` below means a blank line separating groups. Within each group, sort
alphabetically.

## Group order

1. Static imports:
   - `static jakarta.**`, `static java.**`, `static javax.**`, `static javafx.**`
   - *(blank line)*
   - `static org.**`, `static com.**`, all other static imports (`$*`)
2. *(blank line)*
3. Standard imports:
   - `jakarta.**`, `java.**`, `javax.**`, `javafx.**`
   - *(blank line)*
   - `org.**`, `com.**`, all other imports (`*`)
4. *(blank line)*
5. Dedalus-owned imports: `orbis.**`, `ag.gwi.**`, `com.agfa.**`

## Additional import rules

- Never use wildcard / on-demand imports (`import java.util.*;`) — always use
  single-class imports.
- Keep static imports as a separate block, ahead of regular imports.
- Exactly one blank line after the import block (before the type declaration).

## Example

```java
import static java.util.Objects.requireNonNull;

import static org.assertj.core.api.Assertions.assertThat;

import jakarta.ws.rs.GET;
import java.net.URI;
import java.net.http.HttpResponse;
import java.util.List;

import org.keycloak.models.KeycloakSession;
import com.fasterxml.jackson.databind.ObjectMapper;

import orbis.keycloak.idp.license.ExtIdpLicenseChecker;
import com.agfa.shared.SomeType;
```
