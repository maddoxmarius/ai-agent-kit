---
name: dedalus-u-agent
description: Dedalus U Agent runbook
user-invocable: true
disable-model-invocation: false
---

## Git conventions
Name branches using:
```plain text
dev/<target-branch>/<issue-id>-<very-short-description>
```
For example:
```plain text
dev/master/ORBISBUG-53240-filter-roles-with-profiles
```
Commit subjects must follow Conventional Commits and end with the issue ID followed by `/fixed`:
```plain text
<type>: <description> [<issue-id> /fixed]
```
For example:
```plain text
fix: Filter roles by assigned profiles [ORBISBUG-53240 /fixed]
```
Pull request titles must repeat the primary commit subject and append the source target branch:
```plain text
<commit-subject>[<target-branch>]
```
For example:
```plain text
fix: Filter roles by assigned profiles [ORBISBUG-53240 /fixed][master]
```
Do not append the target branch to commit subjects; it belongs only in the pull request title.
Use the Conventional Commits types and optional scopes described at [https://www.conventionalcommits.org/en/v1.0.0/#summary](https://www.conventionalcommits.org/en/v1.0.0/#summary).

## Required environment
Build, test, and run this project inside the `orbisudev` WSL distribution. It provides the required Java 21, Maven, Chromium, and Docker integration.
Do not run Maven, Angular, Yarn, or file-watching development servers directly on Windows or from a repository under `/mnt/c`. Windows-mounted filesystems make dependency installation, compilation, and file watching much slower and can cause permission and path-length problems.
Before running commands, verify the environment:
```bash
java -version
mvn -version
test -S /var/run/docker.sock
```
Java must report version 21 and the Docker socket check must succeed.

## Working from a Windows Copilot worktree
The Windows worktree remains the authoritative source. Create a disposable copy on the native WSL filesystem for validation. Always create a fresh directory so deleted or renamed source files cannot remain in the copy.

From PowerShell, determine the current repository path and convert it to a WSL path:
```powershell
$repo = (git rev-parse --show-toplevel)
$source = (wsl.exe -d orbisudev -- wslpath -u $repo).Trim()
$target = (wsl.exe -d orbisudev -- mktemp -d /home/orbisu/copilot-validation/security-ou.XXXXXX).Trim()
wsl.exe -d orbisudev -- bash -c "tar -C '$source' --exclude=.git --exclude=node_modules --exclude=target --exclude=dist -cf - . | tar -C '$target' -xf -"
```
Run all subsequent build and test commands from `$target`. Do not copy generated files or changes back from the validation directory.
If the repository itself is already checked out below `/home`, work directly in that checkout and skip the copy.

## Backend validation
For focused backend tests, disable frontend resource assembly. Without `-Pno-resources`, Maven's backend assembly expects the frontend package-phase output even during the `test` lifecycle.
```bash
cd /home/orbisu/copilot-validation/security-ou.<suffix>
mvn -pl modules/backend -am \
  -Pno-resources \
  -Dtest=RolesServiceTest,AppProfileAccessControlTest \
  -Dsurefire.failIfNoSpecifiedTests=false \
  test --no-transfer-progress
```
Replace the test class list with the smallest set covering the change. Keep `-Dsurefire.failIfNoSpecifiedTests=false` when using `-am`, because upstream modules do not contain those test classes.

The image digest plugin uses Docker. When Docker access is intentionally unavailable and image resolution is irrelevant to the test, add:
```bash
-DdigestReader.skip=true
```

Run the complete project build when broader validation is required:
```bash
./scripts/build-with-tests.sh
```

## Frontend validation
Install the locked dependencies, build the library first, and then build the application:
```bash
cd modules/frontend/ui
yarn install --frozen-lockfile
yarn run build:lib
yarn run build:app:dev
```
Run the headless unit tests with:
```bash
yarn run test:headless
```
For a production build:
```bash
yarn run build:lib
yarn run build:app:prod
```
Do not use Windows and WSL against the same `node_modules` directory. Install dependencies only in the environment that runs the build.

## Running locally
Start the configured container environment:
```bash
./startup.sh dev
```
Run the backend in Quarkus development mode:
```bash
export PROXY_HOST=<required-upstream-host>
./dev-backend.sh
```
Run the frontend against the development backend:
```bash
./dev-frontend-to-dev-backend.sh
```
Alternatively, run the frontend against the containerized backend:
```bash
./dev-frontend.sh
```
Set `AUTH_URL` when authentication cannot be resolved relative to `PROXY_HOST`.

## Common failures
- `invalid target release: 21`: the command is using Windows Java 17; rerun it in `orbisudev`.
- `\\.\pipe\docker_engine` missing: Maven is running on Windows or Docker is unavailable; use the WSL Docker socket or skip digest lookup for tests.
- `archive cannot be empty` from `copy-frontend`: add `Pno-resources` for backend-only tests, or run a full package/install build.
- `Cannot find module 'security-lib'`: run `yarn run build:lib` before building `security-app`.
- Slow builds under `/mnt/c`: copy the worktree to `/home/orbisu` and run there.
