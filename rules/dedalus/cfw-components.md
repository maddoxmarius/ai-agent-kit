---
description: CFW component usage patterns including import conventions, component APIs, form inputs, grids, and modal patterns
alwaysApply: false
globs: "**/*.ts,**/*.tsx,**/*.html"
ruleSet: dedalus
---

# CFW Component Usage Patterns

## Import Patterns

Import components individually to enable tree-shaking:

```typescript
// ✅ GOOD - Individual imports
import { ButtonModule } from '@ucfw/components/button';
import { GridModule } from '@ucfw/components/grid';
import { AlertModule } from '@ucfw/components/alert';

// ❌ BAD - Barrel imports (if available, may include unused code)
import { ButtonModule, GridModule, AlertModule } from '@ucfw/components';
```

## Component Modules

### Actions & Navigation
- `@ucfw/components/button` - Buttons (`<u-button>`)
- `@ucfw/components/button-group` - Button groups
- `@ucfw/components/breadcrumb` - Breadcrumb navigation
- `@ucfw/components/navbar` - Navigation bar
- `@ucfw/components/tabs` - Tab navigation

### Forms & Inputs
- `@ucfw/components/input` - Text input (`<u-input>`)
- `@ucfw/components/textarea` - Text area
- `@ucfw/components/select` - Dropdown select
- `@ucfw/components/checkbox` - Checkboxes
- `@ucfw/components/radio` - Radio buttons
- `@ucfw/components/toggle-switch` - Toggle switches
- `@ucfw/components/new-calendar` - Date/time picker

### Data Display
- `@ucfw/components/grid` - Data grid (`<u-grid>`)
- `@ucfw/components/list` - List view (`<u-list>`)
- `@ucfw/components/tree` - Tree view (`<u-tree>`)
- `@ucfw/components/badge` - Badges
- `@ucfw/components/avatar` - User avatars
- `@ucfw/components/cards` - Card containers
- `@ucfw/components/icons` - Icon component (`<u-icon>`)

### Feedback & Overlays
- `@ucfw/components/alert` - Alert messages (`<u-alert>`)
- `@ucfw/components/modal` - Modal dialogs
- `@ucfw/components/notification` - Toast notifications
- `@ucfw/components/popover` - Popovers
- `@ucfw/components/tooltip` - Tooltips

## Button Usage

```html
<!-- Primary action -->
<u-button [uType]="'primary'">Save</u-button>

<!-- Secondary action -->
<u-button [uType]="'secondary'">Cancel</u-button>

<!-- Danger action -->
<u-button [uType]="'danger'">Delete</u-button>

<!-- Icon button -->
<u-button [uType]="'icon'" [uAriaLabel]="'Edit'">
 <u-icon [uName]="'edit'"></u-icon>
</u-button>
```

## Form Inputs

```html
<!-- Text input -->
<u-input 
  [(ngModel)]="email" 
  [uPlaceholder]="'Enter email'"
  [uAriaLabel]="'Email address'">
</u-input>

<!-- Select dropdown -->
<u-select 
  [(ngModel)]="selectedValue"
  [uDataSource]="options"
  [uAriaLabel]="'Select option'">
</u-select>

<!-- Checkbox -->
<u-checkbox 
  [(ngModel)]="isChecked"
  [uLabel]="'Accept terms'">
</u-checkbox>
```

## Grid Usage

```html
<u-grid [uDataSource]="dataSource" [uSelectionScope]="'single'">
 <u-grid-header *uGridHeaderDef [uTitle]="{ key: 'Title' }">
 </u-grid-header>
 
 <u-grid-column uName="name" uWidth="200px" [uPin]="'left'">
 <ng-template uGridHeaderCellDef>Name</ng-template>
 <ng-template uGridCellDef let-context>
 {{ context.value.name }}
 </ng-template>
 </u-grid-column>
</u-grid>
```

## Alert Usage

```html
<u-alert [uType]="'success'" [uDismissible]="true">
 Operation completed successfully.
</u-alert>

<u-alert [uType]="'danger'">
 An error occurred. Please try again.
</u-alert>

<u-alert [uType]="'warning'">
 This action cannot be undone.
</u-alert>

<u-alert [uType]="'info'">
 Please review the information below.
</u-alert>
```

## Modal Usage

```typescript
import { ModalService } from '@ucfw/components/modal';

constructor(private modalService: ModalService) {}

openConfirmation() {
 this.modalService.confirm({
 title: 'Confirm Action',
 message: 'Are you sure you want to proceed?',
 confirmLabel: 'Yes',
 cancelLabel: 'No'
 });
}
```

## Icon Usage

```html
<!-- Basic icon -->
<u-icon [uName]="'check'"></u-icon>

<!-- Icon with size -->
<u-icon [uName]="'edit'" [uSize]="'large'"></u-icon>

<!-- Icon in button -->
<u-button [uType]="'icon'">
 <u-icon [uName]="'close'"></u-icon>
</u-button>
```

## Best Practices

- Always import components individually for tree-shaking
- Use `u-` prefix for all CFW components
- Provide `uAriaLabel` for accessibility
- Use semantic types (`primary`, `success`, `danger`, etc.)
- Follow component API conventions
- Use two-way binding `[(ngModel)]` for form inputs
- Provide data sources for data-driven components

## Common Patterns

### Form Layout
```html
<form>
 <u-input 
   [(ngModel)]="formData.email"
   [uLabel]="'Email'"
   [uRequired]="true">
 </u-input>
 
 <u-button [uType]="'primary'" type="submit">
 Save
 </u-button>
</form>
```

### Empty State
```html
<u-empty-state 
 [uIconName]="'info_outline'" 
 [uTitle]="'No data available'"
 [uSize]="'medium'">
</u-empty-state>
```
