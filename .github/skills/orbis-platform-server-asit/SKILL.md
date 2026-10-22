---
name: orbis-platform-server-asit
description: Runs orbis-platform-server Arquillian server integration tests (ASIT) locally the same way as the Jenkins orbis-platform-server_INTEGRATION job — a single test class/method, a module's ASITs, or all ASITs of a branch checkout. Use when the user wants to reproduce or verify an ASIT failure (e.g. *ASIT classes such as CatalogSearchServiceASIT) or run integration tests for an orbis-platform-server branch.
---

# orbis-platform-server ASIT runner

## What it does

Jenkins (`HBA_HFW » orbis-platform-server_INTEGRATION`) runs `mvn clean install -B -PASIT-remote` with JDK 21. The `ASIT-remote` profile:
- starts a WildFly container `oas-hba-arquillian-test/as-wfly:${version.asit.docker.oasimage}` (version from the root `pom.xml`),
- connects it to the shared test DB `${test.release.id}-ENV.DEDALUS.LAN` (e.g. `EOD4442A`) and Keycloak `https://${test.release.id}-proxy.orbis.dedalus.com/auth`,
- deploys the tests via Arquillian and runs `**/*IT.java` with failsafe.

`run-asit.sh` (next to this file) reproduces this in the `orbisudev` WSL distro (Windows has no Docker CLI):
1. copies the checkout to a WSL working copy (default `~/Workspace/tmp/asit/<parent>-<branch>`, without `target`/`.svn`/`.idea`) so the Windows checkout is never touched,
2. pulls `registry-nexus.orbis.dedalus.com/oas-hba-arquillian-test/as-wfly:<tag>` if missing,
3. runs `mvn clean verify -B -PASIT-remote` with JDK 21 (unit tests skipped unless `--with-unit-tests`),
4. writes the full Maven log to `<work>/asit-<timestamp>.log` and prints a summary (per-class results, failures, reactor summary).

## Instructions

1. Determine the branch checkout (e.g. `C:\Workspace\orbis-platform-server\branches\84.4402.x`). Ask if unknown.
2. Determine the scope:
   - **Specific test:** `--test CatalogSearchServiceASIT` (method: `CatalogSearchServiceASIT#testSearchStructure`, wildcard: `'*Catalog*ASIT'`). Also pass `--module` for the module containing the class (find it with `glob` `**/<Class>.java`) — much faster because other modules are not built/tested.
   - **All ASITs of one module:** `--module orbis-server-commons` (modules with ASITs: `orbis-server-commons`, `orbis-framework`, `orbis-user-provisioning`, `orbis-printing-commons`).
   - **All ASITs (like CI):** no `--module`/`--test`. Add `--with-unit-tests` to match CI exactly.
3. Run it from PowerShell. The script lives next to this `SKILL.md` (base directory of the skill); convert that directory to a WSL path (`C:\...` → `/mnt/c/...`) and pipe the script through `tr` to be safe against CRLF. Example for a personal skill install:

   ```powershell
   wsl.exe -d orbisudev -- bash -c "tr -d '\r' < /mnt/c/Users/marius.bordeianu/.copilot/skills/orbis-platform-server-asit/run-asit.sh | bash -s -- --src 'C:\Workspace\orbis-platform-server\branches\84.4402.x' --module orbis-server-commons --test CatalogSearchServiceASIT"
   ```

   - Durations: one class ≈ 4–5 min (container start dominates), one module ≈ 20 min, all modules longer. Use `initial_wait` 600; for full runs use async mode and wait for the completion notification.
   - Extra Maven args go after `--`, e.g. `-- -o` (offline) or `-- -rf :orbis-server-commons`.
   - Env `ASIT_JAVA_HOME` overrides the JDK (default: newest `~/.sdkman/candidates/java/21*`).
4. Report: test counts, failing tests with `Class.method:line`, and the log path. For stack traces read `<work>/<module>/target/failsafe-reports/<Class>.txt` or grep the log (lines prefixed `[oas@docker]` are server logs).
5. When comparing with Jenkins, the build's test report is at `<build-url>/testReport/api/json?tree=failCount,suites[cases[className,name,status,errorStackTrace]]`.

## Prerequisites / troubleshooting

- WSL distro `orbisudev` with Docker, Maven, JDK 21 (sdkman), `~/.m2/settings.xml` with Nexus access, and VPN/network access to `*.DEDALUS.LAN` (DB port 1521) and `registry-nexus.orbis.dedalus.com`. Quick check: `timeout 5 bash -c '</dev/tcp/EOD4442A-ENV.DEDALUS.LAN/1521'`.
- The DB is a shared test DB: data-dependent failures reproduce identically in CI and locally; tests run with `TransactionMode.ROLLBACK` so they do not modify it.
- If a run was interrupted, leftover containers may remain: `docker ps --filter name=asit-orbis-platform-server_` then `docker rm -f <id>`.
- The script exits with Maven's exit code (2 for setup/argument errors).
