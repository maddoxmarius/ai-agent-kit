---
name: ucfw-components
description: Implement, refactor, or review Dedalus ORBIS U interfaces using the U Client Framework and the ucfw-mcp-server documentation tools. Use for Angular UI work involving @ucfw packages, u-* components, CFW design patterns, NICE Fluorine icons, accessibility, framework setup, version compatibility, or migration.
---

# UCFW Components

Use the `ucfw-mcp-server` as the authoritative source for ORBIS U component APIs, examples, design guidance, accessibility behavior, icons, dependencies, and migration instructions. Static project instructions are defaults only; when they conflict with the MCP documentation for the project's installed UCFW version, follow the version-matched MCP documentation.

## Required workflow

1. Inspect the project before choosing an API:
   - Read `package.json` and the lockfile to identify the installed `@ucfw/*` and Angular versions.
   - Reuse the project's existing standalone or NgModule pattern, form strategy, test framework, and nearby UCFW usage.
   - Keep all `@ucfw/*` packages on compatible coexistent versions.
2. Resolve the documentation version:
   - Call `list_versions` and select the guide version matching the installed UCFW major.
   - For a new project, use the latest stable version. Do not select a beta or EOL version unless the user or existing project requires it.
   - If the installed version cannot be determined and the API differs by version, ask the user rather than guessing.
3. Select the component:
   - Call `list_components` when the exact feature name is unknown.
   - Prefer an existing `u-*` component over native controls, third-party widgets, or a custom replacement when UCFW provides the required behavior.
   - Call `get_component_guide` before implementation to understand intended use, variants, labeling, and layout rules.
4. Verify the exact API and implementation:
   - Call `get_component_api` for inputs, outputs, methods, and types.
   - Call `get_component_examples` for real Angular templates, classes, imports, and styles.
   - Never invent selectors, module names, inputs, outputs, enum values, or icon names.
5. Apply design-system guidance:
   - Use `get_design_page` for relevant foundations and patterns such as layout, actions, filters, form validation, search, master/detail, themes, typography, component states, and error notifications.
   - Use `get_getting_started` and `get_framework_dependencies` for setup or dependency work.
   - Use `get_migration_guide` for upgrades; do not infer migration steps from current APIs.
6. Implement accessibility:
   - Call `get_a11y_component` for interactive or stateful components.
   - Use the narrower `get_a11y_aria`, `get_a11y_keyboard_navigation`, `get_a11y_best_practices`, or `get_a11y_wcag` tools when a focused answer is needed.
   - Preserve documented keyboard behavior, focus management, semantics, labels, validation announcements, and WCAG 2.2 AA requirements.
   - Do not add unsupported `uAriaLabel` inputs merely because a generic instruction recommends them; use the component's documented accessibility API.
7. Use approved icons:
   - Call `search_icons` to find a contextually appropriate NICE Fluorine icon.
   - Call `get_icon_info` before implementation to obtain the exact `uName`, template usage, and any mandatory global styles.
   - Do not guess icon names or substitute unrelated icon libraries when a suitable Fluorine icon exists.
8. Validate the result:
   - Run the smallest relevant build, type-check, and tests.
   - Check the result in every supported theme when styles change.
   - Verify keyboard operation and accessible labeling for changed interactive flows.

## Tool selection

| Need | MCP tool |
|---|---|
| Discover components | `list_components` |
| Understand when and how to use a component | `get_component_guide` |
| Verify inputs, outputs, methods, and types | `get_component_api` |
| Get working Angular examples | `get_component_examples` |
| Get complete component accessibility guidance | `get_a11y_component` |
| Inspect ARIA, keyboard, WCAG, or best practices separately | `get_a11y_aria`, `get_a11y_keyboard_navigation`, `get_a11y_wcag`, `get_a11y_best_practices` |
| Find UX foundations and patterns | `list_design_pages`, `get_design_page` |
| Find and verify icons | `list_icon_groups`, `search_icons`, `get_icon_info` |
| Check setup and dependency compatibility | `get_getting_started`, `get_framework_dependencies` |
| Plan framework migration | `get_migration_guide` |
| Read backend/integration resources | `list_resource_pages`, `browse_page` |
| Read an otherwise uncovered guide page | `browse_page` |

## Implementation rules

- Use documented `u-*` components and `u*` inputs.
- Import from the exact package path shown by the version-matched API or examples.
- Use UCFW semantic CSS variables and utilities; do not hardcode colors or recreate theme tokens.
- Follow established Header -> Toolbar -> Content and master/detail patterns when appropriate.
- Keep business logic out of presentation components and preserve strict TypeScript typing.
- Handle loading, empty, validation, error, disabled, read-only, and permission states explicitly.
- Do not mix generic frontend styling guidance with ORBIS U in ways that bypass its typography, color, spacing, component, icon, or interaction systems.
- Do not copy every demo option into production code. Use only the documented features required by the task.

## Expected response behavior

When explaining or implementing UCFW code, briefly identify:

- the selected UCFW component or pattern,
- the guide version used,
- any important accessibility or compatibility constraint.

Do not dump MCP documentation. Apply it to the project and cite the exact component feature names and APIs used.
