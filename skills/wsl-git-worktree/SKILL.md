---
name: wsl-git-worktree
description: Create or repair native WSL Git worktrees with authenticated origin access, standard branch fetching, explicit upstream tracking and working git pull. Use when creating a WSL development checkout or synchronizing a Copilot PR branch into orbisudev.
user-invocable: true
disable-model-invocation: false
---

# Native WSL Git worktrees

Create a real Git-backed worktree on the native Linux filesystem, not a tar copy,
Windows-mounted repository or folder without Git metadata. Defaults:

- Distribution: `orbisudev`.
- Existing WSL repository: `/home/orbisu/Workspace/<repository>`.
- Worktree: `/home/orbisu/Workspace/copilot-worktrees/<repository>/<issue-id>-<short-description>`.
- Remote: `origin`, retaining the repository's existing URL.
- For Dedalus work, follow `dedalus-u-agent` for branch/commit/PR conventions and validation.

Use paths and targets supplied by the user in preference to these defaults.
Do not create a worktree merely because a task uses WSL; use this skill when requested.

## Safety and ownership

Operate only on the explicitly identified WSL repository/worktree. Do not inspect
or modify an app-managed main checkout. An existing WSL repository may have other
worktrees and uncommitted work: inspect it before changing shared Git configuration.
Never reset, force-checkout, clean, stash, delete, or overwrite user changes.
Never use `git worktree add --force` to check out a branch already in another worktree.

An app-managed Windows worktree and a WSL checkout are separate repositories.
Choose the authoritative source explicitly:

- When synchronizing an existing app PR, the app checkout owns commits/PR updates.
  Fetch the actual published PR head into WSL for development or validation.
- When the user requests WSL-only development, the WSL worktree owns source edits.
  Do not claim an app-native PR can be created for an unrelated session checkout.

Prefer committed changes transferred via push/fetch/pull. Never copy `node_modules`,
`dist`, `target`, generated output, `.git` or Git worktree metadata between checkouts.
If uncommitted source changes must move, review and transfer a scoped patch, with
explicit approval and conflict checks, rather than copying entire folders.

## PowerShell-to-WSL commands

Run Git setup and all builds/tests inside `orbisudev`. Use `wsl.exe -d orbisudev --`
from PowerShell. For commands containing shell variables, prefer a script passed
as a file on the native WSL filesystem or an appropriately escaped stdin script.
Windows-to-WSL argument quoting can expand `$variables` or `$(commands)` before
Bash receives them. Avoid unquoted `$PATH`; prefer an explicit native PATH.
Check output and exit status; a final `tail` must not hide a failed command.

The Bash examples below run inside WSL. Resolve the placeholder values first;
do not blindly execute example paths or branch names.

## 1. Inspect and authenticate

Record the source repository path, target path, branch, remote URL and intended
base. For an existing PR, read its current head/base; do not derive the head from
the requested branch name. The Copilot app may prepend a configured prefix.

```bash
git -C "$repo" status --short --branch
git -C "$repo" worktree list --porcelain
git -C "$repo" remote -v
git -C "$repo" config --get-all remote.origin.fetch
timeout 30 env GIT_TERMINAL_PROMPT=0 git -C "$repo" ls-remote --heads origin
```

If the repository does not exist, clone the user-identified repository to the
native WSL path. Do not overwrite an existing directory. Do not use `--single-branch`.

If remote access fails, report the exact failure. Inspect helper configuration
without displaying tokens. Where GitHub CLI is already installed and signed in,
`gh auth setup-git --hostname github.com` can configure its credential helper.
Do not copy tokens between Windows/WSL, embed credentials in URLs, print secrets,
or start an interactive login without the user's participation.

## 2. Ensure standard remote fetching

Default fetch mapping:

```text
+refs/heads/*:refs/remotes/origin/*
```

A single-branch clone can retain a narrow refspec for a deleted branch. This
breaks fetch/pull even when authentication and the URL work. Inspect all mappings
first. Preserve intentional custom remotes and non-head mappings.

For an ordinary repository whose only mapping is a narrow heads refspec, replace
that exact mapping with the standard one:

```bash
git -C "$repo" config --replace-all --fixed-value remote.origin.fetch \
    '+refs/heads/*:refs/remotes/origin/*' "$old_refspec"
```

If no mapping exists, add the standard mapping. If several mappings exist, keep
intentional custom mappings; remove only obsolete/duplicated narrow head entries.
Do not blindly unset the entire list. Configuration is shared by sibling worktrees.
Explain any change to the user.

Then fetch, without pruning unrelated refs:

```bash
timeout 90 env GIT_TERMINAL_PROMPT=0 git -C "$repo" fetch origin
```

## 3. Create or reuse the worktree

Verify the target path is unused and the requested branch is not checked out in
another worktree. If it is already checked out, use that worktree rather than
creating a second checkout of the same branch.

For an existing remote PR branch, use its exact head name:

```bash
git -C "$repo" worktree add --track -b "$branch" "$target" "origin/$branch"
```

If the local branch already exists but is not checked out elsewhere:

```bash
git -C "$repo" worktree add "$target" "$branch"
```

For a new branch, verify `origin/$base` exists, then:

```bash
git -C "$repo" worktree add -b "$branch" "$target" "origin/$base"
```

A new branch created from the base is not the base branch. Do not leave it tracking
`origin/$base` and call that correct PR tracking. Remove any inherited upstream,
then publish only when authorized by the requested workflow:

```bash
git -C "$target" branch --unset-upstream "$branch"
git -C "$target" push --set-upstream origin "$branch"
```

Run `--unset-upstream` only if an upstream exists. If publication is not authorized,
report that normal pull will become available after publishing; do not push silently.

For an existing remote branch, set tracking explicitly:

```bash
git -C "$target" branch --set-upstream-to="origin/$branch" "$branch"
```

If a pre-existing local branch differs from the remote, inspect divergence and
local modifications. Do not reset or invent a merge/rebase strategy.

## 4. Verify pull behavior

```bash
git -C "$target" status --short --branch
git -C "$target" rev-parse --abbrev-ref --symbolic-full-name '@{upstream}'
timeout 60 env GIT_TERMINAL_PROMPT=0 git -C "$target" pull --ff-only
git -C "$target" rev-list --left-right --count 'HEAD...@{upstream}'
```

For a clean synchronized checkout, expect the exact intended remote branch and
`0 0`. Verify ordinary `git pull` from the user's working subdirectory only after
confirming it is already synchronized; it should say `Already up to date`.
Do not enable global pull settings or silently reconcile divergent histories.

For `Cannot fast-forward to multiple branches`, inspect all branch merge entries,
fetch mappings and concurrent Git activity. Do not run concurrent fetch/pull calls
against the shared repository. Repair only confirmed duplicate/wrong mappings.

## 5. Native development environment

For Dedalus projects, verify Java 21, Maven and the Docker socket before builds.
WSL may default to a different Java version; select an installed Java 21 through
`JAVA_HOME` and PATH for the command, without changing global defaults.

Restore locked dependencies in WSL when missing, build the library before the
app/demo, and reuse existing test tooling (Cypress here, not a new browser framework).
Resolve the actual Chromium binary; do not assume `/usr/bin/chromium` exists.
Keep temporary servers bounded and stop them when their checks finish.

## Completion report

Report the native worktree path, exact branch/upstream, updated commit and pull
result. Mention any shared fetch configuration change, divergence, preserved
local changes or pending publication. Never claim success based solely on
`git remote -v`; authenticated fetch and working upstream tracking are required.
