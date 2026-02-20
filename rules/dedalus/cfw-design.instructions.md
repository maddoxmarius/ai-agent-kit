# CFW Design System Instructions

These instructions apply when working with U Client Framework (CFW) design system files (`**/*.ts`, `**/*.tsx`, `**/*.scss`, `**/*.html`).

## Component Naming

All CFW components use the `u-` prefix:
- `<u-button>` for buttons
- `<u-input>` for text inputs
- `<u-alert>` for alerts
- `<u-icon>` for icons
- `<u-grid>` for data grids

Component inputs use the `u` prefix: `[uType]`, `[uSize]`, `[uDisabled]`, etc.

## Color System

Always use CSS variables, never hardcoded colors:
- `var(--u-content-item-major-bg)` for backgrounds
- `var(--u-content-item-major-fg)` for text
- `var(--u-action-*)` for primary/action colors
- `var(--u-feedback-success-*)` for success states
- `var(--u-feedback-danger-*)` for error states

## Typography

Base font size: 14px (1rem = 14px)
- Use CSS variables: `--u-font-size-xxxl` through `--u-font-size-sm`
- Font weight: 400 (regular) or 500 (medium)
- Line height: 1.5 (normal) or 1.25 (tight)

## Layout Patterns

Standard view structure:
1. Header/Headline with navigation
2. Toolbar (optional) with filters and actions
3. Content area (list, grid, form, etc.)

Use `<u-header-toolbar>`, `<u-filter>`, and `<u-grid>` components.

## Theming

Available themes: `u-light`, `u-dark`, `u-radiology`, `u-icas-blue`, `u-icas-green`, `u-light-a11y`

Use `UThemeModule.forRoot()` to configure themes.

## Accessibility

- WCAG 2.2 Level AA compliance required
- Provide `uAriaLabel` for all interactive elements
- Ensure 4.5:1 color contrast minimum
- Support keyboard navigation
- Test with screen readers
