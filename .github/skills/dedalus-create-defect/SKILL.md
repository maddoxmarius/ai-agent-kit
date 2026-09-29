---
name: dedalus-create-defect
description: Creates a defect/bug report from conversation context, code, logs, or error messages, following the Dedalus defect template. Generates the title automatically and writes the description from the user's/end-user's perspective. Use when the user asks to file, log, report, or create a defect, bug, or issue for a problem being discussed.
---

# Dedalus Create Defect

## Instructions

Use this skill whenever the user asks to create, file, log, or report a defect/bug based on something discussed in the conversation (an error, a reproduction they described, a stack trace, a screenshot, or a code investigation).

### 1. Gather context

Before writing the defect, collect everything relevant from the conversation and workspace:

- The problem description, error messages, stack traces, or logs shared by the user.
- Steps the user performed (or that you performed while investigating) that trigger the issue.
- Any code you inspected that explains the root cause (only for the optional "Proposed Fix" section — never invent behavior you haven't verified).
- Environment details mentioned or discoverable: OS, browser/device, environment (test/staging/production/local), build/version number.
- Any test data referenced (usernames, sample files, IDs).

If critical information is missing (e.g. no steps to reproduce, no environment), ask the user targeted clarifying questions one at a time rather than guessing or leaving sections blank with placeholder text.

**Never include real patient, study, or other sensitive/PII data.** If such data is relevant, anonymize it or refer to it only by an opaque identifier (e.g. "patient ID 12345"), and say so explicitly if you had to omit or anonymize something.

### 2. Write from the user's perspective

The defect must be understandable by someone who did not witness the bug:

- Describe symptoms and impact in plain, non-technical language wherever possible.
- Avoid internal jargon, variable names, or implementation details in the High-Level Summary, Steps to Reproduce, Expected Result, and Actual Result sections — save technical detail for the Technical Information and Proposed Fix sections.
- Be specific and concrete; do not skip steps that seem "obvious".

### 3. Generate the title

Generate a concise, descriptive title (not provided by the user) that:

- States what is broken and where (component/page/feature), similar in style to: `<Area>: <short problem statement>`.
- Is written from the user's perspective (what they observe), not the root cause.
- Is under ~80 characters, no trailing period.
- Examples: `Login: Sign-in button unresponsive on Safari 15`, `Patient search: results grid fails to load after filter change`.

### 4. Fill in the template

Produce the defect using exactly this structure and section order (omit "Proposed Fix" entirely if you have no grounded suggestion — do not fabricate one):

```
High-Level Summary

<1-3 sentences: what the issue is, where it occurs, potential impact>

Steps to Reproduce

1. <step>
2. <step>
3. <step>

Expected Result

<what should happen>

Actual Result

<what actually happens; note if screenshots/recordings are available>

Test Data (if available)

<anonymized test data, or "N/A" if none>

Technical Information

Platform/Operating System: <value or "Unknown">
Browser/Device: <value or "Unknown">
Environment: <test/staging/production/local or "Unknown">
Build Number: <value or "Unknown">
Logs: <attached/summarized logs with timestamps, or "None available">

Proposed Fix (optional)

<possible cause(s) and areas to investigate, only if you have concrete grounds — omit section otherwise>
```

- If a field is genuinely unknown after asking the user, write "Unknown" (or "N/A" for Test Data) rather than leaving it blank or inventing a value.
- Keep the High-Level Summary to 1-3 sentences as specified in the template.

### 5. Create the defect

- If the workspace/session has an issue-tracking integration available (e.g. GitHub issues via the `create_issue` tool, or a Jira MCP server), use it to actually create the defect with the generated title and the filled template as the body/description.
- If multiple trackers are available or it's ambiguous where the defect should go, ask the user which one to use.
- If no issue-tracking tool is available, present the generated title and full filled-in template to the user as the final output so they can file it manually.

### 6. Confirm

After creating the defect (or presenting it), briefly confirm the title and where it was filed (or that it needs to be filed manually), and summarize any information you had to mark "Unknown" so the user can fill it in later.

## Example

**User:** "Can you file a defect? The export button on the reports page does nothing when clicked in Chrome on our staging environment, build 4.12.3. I clicked it twice and nothing happened, no error in the console."

1. Context gathered: page (reports), action (export button click), browser (Chrome), environment (staging), build (4.12.3), actual result (nothing happens, no console error).
2. Missing: OS, exact reproduction steps beyond "clicked export", expected result — ask the user only if needed, otherwise infer reasonable expected behavior ("clicking Export should download/generate the report").
3. Generated title: `Reports: Export button unresponsive on staging (build 4.12.3)`
4. Fill the template with the gathered facts, mark unknown fields (e.g. OS) as "Unknown".
5. Create the defect via the available tracker, or present the completed template if none is available.
