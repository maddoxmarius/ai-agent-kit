---
name: dedalus-german-translations
description: Ensures user-facing text changes add or update German (`de`) translations only. Use when explicitly requested to add, update, or review translations in a Dedalus repository.
---

# Dedalus German Translations

## Instructions

Use this skill when the user explicitly references `dedalus-german-translations`, or asks to add, update, or review translations for user-facing text in a Dedalus repository.

### Translation scope

- Add or update the German (`de`) resource or locale key/value only.
- Do not add English or any other non-German locale translations.
- Leave all other locale files untouched.
- If existing non-German entries are encountered, do not remove or modify unrelated entries.
- Missing non-German translations are expected and are handled later by the team's established translation process.

### Implementation workflow

1. Identify the user-facing text and the resource or locale files that contain it.
2. Locate the German (`de`) resource using the repository's existing naming and directory conventions.
3. Add or update only the German key/value.
4. Preserve the existing key structure, formatting, interpolation placeholders, and escaping.
5. Do not create fallback English entries or populate other locale files.
6. Verify that unrelated locale files were not changed.

### Validation

- Check the diff to confirm only German translation resources were modified.
- Confirm placeholders and key names remain consistent with the source text.
- Run the repository's smallest relevant translation, lint, or test check when one exists.
- If the German resource or required context cannot be identified, ask for clarification instead of modifying another locale.
