---
name: my-jira-work
description: Lists the current user's or a named person's open Jira work using the Dedalus Jira MCP server. Use for requests like "what's my Jira work", "extract my work to be done from Jira", or "my open tickets".
---

# My Jira Work

## Instructions

Use this skill when the user wants a list of Jira issues assigned to themselves or another person.

### 1. Identify the person and verify Jira access

1. Call `connection_info` to verify the Dedalus Jira MCP connection and identify the authenticated Jira user. If the user did not name someone else, use its `accountId`; if none is returned, resolve the authenticated user's display name with `search_users`.
2. If the user names a person, resolve them with `search_users` and use the returned Jira Cloud `accountId` in JQL. If there are no matches, report that the person was not found. If there are multiple plausible matches, ask the user which one to use before querying issues.
3. Compare the requested person's identity with the authenticated Jira user. If they differ, warn that results are limited to issues visible to the authenticated account; continue only with the requested person's account ID.

### 2. Choose the issue scope

Use the broad default unless the user asks for actionable work only:

```jql
assignee = "<accountId>" AND status != Closed ORDER BY priority DESC, updated DESC
```

This includes every status except `Closed`, including `Resolved` and `Done`. For actionable-only work, use:

```jql
assignee = "<accountId>" AND status NOT IN (Resolved, Closed, Done) ORDER BY priority DESC, updated DESC
```

Do not substitute `statusCategory != Done`: `Resolved` may not belong to the `Done` category. If the user's requested scope is unclear and would materially change the results, clarify before searching; otherwise state which scope was used.

### 3. Retrieve and paginate issues

1. Call `search_issues` with the selected JQL.
2. Continue calling it with each returned `nextPageToken` as `next_page_token` until `isLast` is true. Do not report a partial first page as the complete result.
3. If the search returns no issues, say so plainly and include the scope used.

### 4. Get details and open subtasks for actionable issues

For issues in active work statuses, such as `Implementation` or `Implementation - Ongoing`, call `get_issue` with comments included. Use the description and comments as evidence for the next step; if comments are truncated and more are needed, retrieve them with `get_issue_comments`.

List open subtasks for each actionable issue. Use subtasks returned by `get_issue` when their status is available; otherwise query `parent = "<issue key>" AND status != Closed`, using the selected actionable scope when applicable. Do not invent subtasks or treat closed subtasks as open.

### 5. Present the work

Group results by status and present a table for each group with these columns: Jira-linked key, type, priority, status, summary, and updated date. Preserve Jira's priority and updated ordering within each status group. Build issue links from the Jira base URL returned by `connection_info`; if it is unavailable, show the key without guessing a host.

After the tables, provide a short **Next step** for each actionable issue, grounded in its description and comments. Mention open subtasks where relevant. If the available Jira content does not support a concrete next step, say that no explicit next step was identified rather than guessing.

If a canvas is available and useful, optionally offer to display the results in a filterable list. Use status colors only when supported by that canvas (for example, green for `Resolved` and blue for `Implementation` statuses).

### 6. Handle errors explicitly

- If the Dedalus Jira MCP server is unavailable, explain that it must be configured in the project.
- If `connection_info` reports an authentication or connection failure, explain that the Jira connection must be authenticated, and do not present results as if the query succeeded.
- If the requested person is not found or has multiple plausible matches, report that clearly; ask the user to select a match when needed.
- If permissions prevent access to issues or details, report the limitation and do not infer missing data.
- If there are no matching issues, report an empty result rather than implying an error.

## Examples

### Current user's open work

**User:** "What's my Jira work? I'm Marius Bordeianu."

Resolve the named person with `search_users`, check the connected account with `connection_info`, and list their issues using the default scope (everything not `Closed`).

### Include everything not Closed

**User:** "Include everything not Closed."

Use the default JQL scope, which includes `Resolved` and `Done`, and state that choice in the results.

### Only actionable items

**User:** "Only actionable items."

Use `status NOT IN (Resolved, Closed, Done)`, then fetch actionable issue details and comments and list their open subtasks.
