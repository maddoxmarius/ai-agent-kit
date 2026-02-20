# CFW Component Usage Instructions

These instructions apply when using CFW components (`**/*.ts`, `**/*.tsx`, `**/*.html`).

## Import Patterns

Import components individually for tree-shaking:
```typescript
import { ButtonModule } from '@ucfw/components/button';
import { GridModule } from '@ucfw/components/grid';
import { AlertModule } from '@ucfw/components/alert';
```

## Component Usage

### Buttons
```html
<u-button [uType]="'primary'">Save</u-button>
<u-button [uType]="'secondary'">Cancel</u-button>
<u-button [uType]="'danger'">Delete</u-button>
```

### Form Inputs
```html
<u-input [(ngModel)]="value" [uPlaceholder]="'Enter text'"></u-input>
<u-select [(ngModel)]="selected" [uDataSource]="options"></u-select>
<u-checkbox [(ngModel)]="checked" [uLabel]="'Label'"></u-checkbox>
```

### Grid
```html
<u-grid [uDataSource]="dataSource" [uSelectionScope]="'single'">
 <u-grid-column uName="name">
 <ng-template uGridCellDef let-context>{{ context.value.name }}</ng-template>
 </u-grid-column>
</u-grid>
```

### Alerts
```html
<u-alert [uType]="'success'" [uDismissible]="true">Success message</u-alert>
<u-alert [uType]="'danger'">Error message</u-alert>
```

## Best Practices

- Always use `u-` prefix for CFW components
- Provide `uAriaLabel` for accessibility
- Use semantic types (`primary`, `success`, `danger`, etc.)
- Use two-way binding `[(ngModel)]` for form inputs
- Import components individually, not from barrel exports
