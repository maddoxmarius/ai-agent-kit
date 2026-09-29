---
name: jira-issue-details
description: Fetches and summarizes Jira issue details by key or URL using the Atlassian MCP server. Use when the user asks to look up a Jira ticket, issue, story, or bug by its Jira ID (e.g. PROJ-123) or by a Jira issue URL.
---

# Jira Issue Details

## Instructions

Use this skill when the user wants information about a specific Jira issue and provides a Jira issue key (e.g. PROJ-123, LW-456), a Jira issue URL, or a phrase like "show me Jira PROJ-123" or "what is in ticket LW-456?".

### 1. Identify the Jira key

1. Parse the user's request for a Jira identifier:
   - Prefer standard Jira keys (e.g. ABC-123).
   - If the user provides a full URL, extract the key from the path (e.g. /browse/PROJ-123).
2. If multiple keys appear, ask which one to focus on before fetching.

### 2. Use the Jira/Atlassian integration

1. Use the configured Jira MCP/Atlassian server (e.g. server name `atlassian`) if available to query Jira.
2. If a call fails due to missing authentication or invalid credentials:
   - Tell the user the Atlassian integration needs authentication.
   - Instruct them to run the `mcp_auth` tool for the Atlassian server (with an empty arguments object) and complete any sign-in flow.
   - After authentication, retry the lookup.
3. If no Jira/Atlassian integration is available, explain that the skill requires a Jira/Atlassian MCP server to be installed and authenticated in this environment.

### 3. Fetch issue details

Use the Jira tools from the Atlassian MCP server to retrieve full details for the given key. Include when available:

- Issue key, type (Story, Bug, Task, Epic, etc.), summary, status (and status category), priority
- Assignee, reporter
- Labels/tags, created and updated timestamps
- Sprint or board information
- Description (plain or markdown)
- Parent, sub-tasks, related issues
- Recent comments (author, timestamp, excerpt)

If the issue key is invalid or not found, say so clearly; do not invent data.

### 4. Present a concise summary

Format the response in clear sections:

- **Issue**: Key, type, summary, status, priority
- **People**: Assignee, reporter
- **Timing**: Created, updated
- **Labels**: List or "None"
- **Description**: Main text; truncate long descriptions and note that they were truncated
- **Links**: Parent, sub-tasks, Jira URL to open in browser
- **Recent Comments**: Last 3–5 comments with author, timestamp, and short excerpt (truncate long comments)

### 5. Error handling

- **Issue not found**: State that the issue could not be found and suggest the user verify the key.
- **Permission denied**: Explain that the current credentials do not have access to that issue.
- **Missing fields**: Report "Not set" or "—" for missing fields; do not guess or fabricate.

## Examples

### Single key

**User:** "Show me the details for Jira ticket PROJ-123."

Extract key PROJ-123, fetch via Atlassian MCP, return the structured summary (Issue, People, Timing, Labels, Description, Links, Recent Comments).

### URL

**User:** "What is in this ticket? https://company.atlassian.net/browse/LW-764"

Extract key LW-764 from the URL, fetch the issue, summarize, and include the Jira URL in the response.

### Multiple keys

**User:** "Compare LW-101 and LW-202."

Identify both keys. Either fetch both and present side-by-side or ask the user if they want one issue first or a comparison, then fetch and summarize accordingly.
