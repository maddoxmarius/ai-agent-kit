# GitHub Copilot Instructions - Dedalus CFW

These instructions apply to all Dedalus projects using the U Client Framework (CFW) design system.

## CFW Design System

### Component Naming
- All components use `u-` prefix: `<u-button>`, `<u-input>`, `<u-alert>`, `<u-grid>`
- Component inputs use `u` prefix: `[uType]`, `[uSize]`, `[uDisabled]`

### Color System
- Always use CSS variables: `var(--u-content-item-major-bg)`, `var(--u-action-*)`
- Never use hardcoded hex colors
- Use semantic color roles: `--u-action-*`, `--u-feedback-*`, `--u-content-*`

### Typography
- Base font size: 14px (1rem = 14px)
- Use CSS variables: `--u-font-size-xxxl` through `--u-font-size-sm`
- Font weights: 400 (regular) or 500 (medium)

### Layout Patterns
- Standard view: Header → Toolbar → Content
- Use `<u-header-toolbar>`, `<u-filter>`, `<u-grid>` components
- Support master/detail patterns

## Component Usage

### Import Patterns
Import components individually for tree-shaking:
```typescript
import { ButtonModule } from '@ucfw/components/button';
import { GridModule } from '@ucfw/components/grid';
```

### Common Components
- Buttons: `<u-button [uType]="'primary'">`
- Inputs: `<u-input [(ngModel)]="value">`
- Grids: `<u-grid [uDataSource]="data">`
- Alerts: `<u-alert [uType]="'success'">`

## Styling Guidelines

- Use CSS variables, never hardcoded values
- Prefer utility classes when possible
- Use semantic color roles
- Ensure 4.5:1 color contrast minimum
- Test across themes

## Accessibility

- WCAG 2.2 Level AA compliance required
- Provide `uAriaLabel` for all interactive elements
- Support keyboard navigation
- Test with screen readers

## Angular Patterns

- Use OnPush change detection when possible
- Implement proper error handling with RxJS
- Separate business logic from presentation
- Use dependency injection properly
- Write comprehensive unit tests (80%+ coverage)

## Best Practices

- Follow CFW design system guidelines
- Use TypeScript strict mode
- Write self-documenting code
- Handle errors explicitly
- Test critical user flows
- Document complex business logic
