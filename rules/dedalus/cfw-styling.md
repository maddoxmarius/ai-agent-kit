---
description: CFW styling guidelines including CSS variable usage, utility classes, custom styles, and theme customization
alwaysApply: false
globs: "**/*.scss,**/*.css"
ruleSet: dedalus
---

# CFW Styling Guidelines

## CSS Variables

### Always Use CSS Variables

```scss
// ✅ GOOD - Use CSS variables
.my-component {
  background-color: var(--u-content-item-major-bg);
  color: var(--u-content-item-major-fg);
  border-color: var(--u-content-item-major-border);
  padding: var(--u-spacing-md);
}

// ❌ BAD - Hardcoded values
.my-component {
  background-color: #ffffff;
  color: #333333;
  border-color: #cccccc;
  padding: 16px;
}
```

### Variable Naming Patterns

- `--u-content-*` - Content colors (backgrounds, text, borders)
- `--u-action-*` - Action/primary colors
- `--u-feedback-*` - Feedback colors (success, warning, danger, info)
- `--u-spacing-*` - Spacing values
- `--u-font-*` - Typography variables
- `--u-app-severity-*` - Severity scale colors

## Utility Classes

Use Bootstrap-based utility classes:

### Display
```html
<div class="d-flex">Flex container</div>
<div class="d-block">Block element</div>
<div class="d-none">Hidden element</div>
```

### Flexbox
```html
<div class="d-flex flex-column">
<div class="d-flex justify-content-between">
<div class="d-flex align-items-center">
```

### Spacing
```html
<div class="m-3">Margin all sides</div>
<div class="p-2">Padding all sides</div>
<div class="mt-4">Margin top</div>
<div class="pb-1">Padding bottom</div>
```

### Text
```html
<p class="text-primary">Primary text</p>
<p class="text-center">Centered text</p>
<p class="font-weight-bold">Bold text</p>
```

### Borders
```html
<div class="border">Border</div>
<div class="border-top">Top border</div>
<div class="rounded">Rounded corners</div>
```

## Custom Styles

### When Writing Custom Styles

```scss
// ✅ GOOD - Use CSS variables
.my-component {
  background-color: var(--u-content-item-major-bg);
  color: var(--u-content-item-major-fg);
  border-color: var(--u-content-item-major-border);
  
  &:hover {
    background-color: var(--u-content-item-major-bg-hover);
  }
  
  &:active {
    background-color: var(--u-content-item-major-bg-pressed);
  }
}

// ❌ BAD - Hardcoded values
.my-component {
  background-color: #ffffff;
  color: #333333;
  border-color: #cccccc;
  
  &:hover {
    background-color: #f5f5f5;
  }
}
```

### SCSS Guidelines

- Use CSS variables, not SCSS color manipulation functions
- Don't use `darken()`, `lighten()`, `mix()` with hardcoded colors
- Use CSS variables for all color values
- Leverage utility classes when possible
- Keep custom styles minimal

## Theme Customization

### Creating Custom Themes

When creating custom themes:
- Update only hue and saturation values (preferred)
- Only update lightness if absolutely necessary
- Round values up/down
- Don't use transparency unless variable includes "-translucent"
- Reuse existing colors when possible

### Theme Variables

```scss
// Theme-specific overrides
[data-theme="custom-theme"] {
  --u-action-primary: hsl(210, 70%, 50%);
  --u-action-primary-hover: hsl(210, 70%, 45%);
  --u-action-primary-pressed: hsl(210, 70%, 40%);
}
```

## Responsive Design

### Breakpoints

```scss
--breakpoint-xs: 0;
--breakpoint-sm: 576px;
--breakpoint-md: 768px;
--breakpoint-lg: 992px;
--breakpoint-xl: 1200px;
```

### Responsive Patterns

```scss
// Mobile-first approach
.component {
  padding: var(--u-spacing-sm);
  
  @media (min-width: 768px) {
    padding: var(--u-spacing-md);
  }
  
  @media (min-width: 1200px) {
    padding: var(--u-spacing-lg);
  }
}
```

## Best Practices

- Always use CSS variables from the design system
- Prefer utility classes over custom styles
- Use semantic color roles
- Ensure sufficient contrast (minimum 4.5:1)
- Test styles across themes
- Use responsive breakpoints appropriately
- Keep custom styles minimal and focused

## Anti-Patterns

```scss
// ❌ DON'T - Hardcoded colors
.component {
  color: #333;
  background: white;
}

// ❌ DON'T - SCSS color manipulation
.component {
  background: darken(#fff, 10%);
}

// ❌ DON'T - Arbitrary values
.component {
  padding: 13px;
  margin: 7px;
}

// ✅ DO - Use variables and utilities
.component {
  color: var(--u-content-item-major-fg);
  background: var(--u-content-item-major-bg);
  padding: var(--u-spacing-md);
  margin: var(--u-spacing-sm);
}
```
