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

---


# CFW Design System Guidelines

## Component Naming

All CFW components use the `u-` prefix:

```html
<!-- ✅ GOOD -->
<u-button [uType]="'primary'">Click me</u-button>
<u-input [(ngModel)]="value"></u-input>
<u-alert [uType]="'success'">Operation successful</u-alert>
<u-icon [uName]="'check'"></u-icon>
<u-grid [uDataSource]="dataSource"></u-grid>

<!-- ❌ BAD -->
<button class="primary">Click me</button>
<input [(ngModel)]="value">
<div class="alert-success">Operation successful</div>
```

### Component Inputs

All component inputs use the `u` prefix:

```html
<u-button [uType]="'primary'" [uSize]="'large'" [uDisabled]="false">
<u-alert [uType]="'danger'" [uDismissible]="true">
<u-grid [uDataSource]="data" [uSelectionScope]="'single'">
```

## Color System

### Use CSS Variables, Never Hardcoded Colors

```scss
// ✅ GOOD - Use CSS variables
.my-component {
  background-color: var(--u-content-item-major-bg);
  color: var(--u-content-item-major-fg);
  border-color: var(--u-content-item-major-border);
}

// ❌ BAD - Hardcoded colors
.my-component {
  background-color: #ffffff;
  color: #333333;
  border-color: #cccccc;
}
```

### Color Roles

Use semantic color roles:
- `--u-action-*` - Primary/action colors
- `--u-feedback-success-*` - Success states
- `--u-feedback-warning-*` - Warning states
- `--u-feedback-danger-*` - Error/danger states
- `--u-feedback-info-*` - Informational content
- `--u-content-*` - Backgrounds, borders, neutral elements

### Severity Colors

For graduated severity indication (0-10 scale):
```scss
var(--u-app-severity-0) /* through */ var(--u-app-severity-10)
```

## Typography System

### Font Stack

Use system fonts:
```scss
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 
 'Helvetica Neue', Arial, 'Noto Sans', sans-serif,
 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 
 'Noto Color Emoji';
```

### Type Scale

Base font size: **14px** (1rem = 14px)

| Style | Size | Weight | CSS Variable |
|-------|------|--------|--------------|
| H1 | 2rem (28px) | 500 | `--u-font-size-xxxl` |
| H2 | 1.75rem (24.5px) | 500 | `--u-font-size-xxl` |
| H3 | 1.5rem (21px) | 500 | `--u-font-size-xl` |
| H4 | 1.25rem (17.5px) | 500 | `--u-font-size-lg` |
| H5 | 1.125rem (15.75px) | 500 | `--u-font-size-md` |
| H6 | 1rem (14px) | 500 | `--u-font-size-base` |
| Body | 1rem (14px) | 400 | `--u-font-size-base` |
| Small | 0.875rem (12.25px) | 400 | `--u-font-size-sm` |

## Layout Patterns

### View Structure

Standard view layout:
1. **Header/Headline** - Application or screen name
2. **Toolbar** (optional) - Filters and actions
3. **Content** - Main content area (list, grid, form, etc.)

```html
<u-header-toolbar [uTitle]="'Page Title'">
 <!-- Toolbar actions -->
</u-header-toolbar>
<u-filter>
 <!-- Filter controls -->
</u-filter>
<u-grid [uDataSource]="data">
 <!-- Grid content -->
</u-grid>
```

### Master/Detail Pattern

Use for navigating elements with drill-down data:
- **Stacked style**: For limited screen space (mobile)
- **Side-by-side style**: For wider screens (desktop)

## Theming

### Available Themes

| Theme | Internal Name | Purpose |
|-------|---------------|---------|
| Light (default) | `u-light` | Standard light theme |
| Dark | `u-dark` | Low-light environments |
| Radiology | `u-radiology` | Radiology applications |
| ICAS Blue | `u-icas-blue` | ICAS branding |
| ICAS Green | `u-icas-green` | ICAS branding |
| Light A11Y | `u-light-a11y` | Enhanced accessibility |

### Theme Implementation

```typescript
import { UThemeModule } from '@ucfw/styles';

@NgModule({
 imports: [
 UThemeModule.forRoot({
 styleSheetContentRoot: 'assets/themes/'
 })
 ]
})
export class AppModule {}
```

## Accessibility (A11Y)

### Compliance Requirements

- **WCAG 2.0 Level A** - Minimum requirement
- **WCAG 2.2 Level AA** - Target compliance
- **EN 301 549** - European accessibility standard

### Core Requirements

1. **Screen Reader Support** - All visual information must have audio equivalents
2. **Keyboard Navigation** - Complete accessibility via keyboard
3. **Color Contrast** - Minimum 4.5:1 ratio for text and icons
4. **Font Size** - Must be globally adjustable by users

### Accessible Labels

Always provide accessible labels:

```html
<u-button [uAriaLabel]="'Close dialog'">
 <u-icon [uName]="'close'"></u-icon>
</u-button>

<u-input [uAriaLabel]="'Search patients'" [(ngModel)]="search"></u-input>
```

## Best Practices

- Never use hardcoded hex colors
- Always use CSS variables from the design system
- Ensure sufficient color contrast (minimum 4.5:1)
- Use semantic color roles, not arbitrary colors
- Test with keyboard navigation
- Verify screen reader compatibility
- Use proper ARIA labels

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

---


# Dedalus Coding Conventions

## Project Structure

### Angular Project Layout

```
src/
├── app/
│   ├── components/     # Reusable components
│   ├── pages/         # Page components
│   ├── shared/        # Shared modules and utilities
│   ├── services/       # Business logic services
│   ├── models/         # Data models and interfaces
│   └── app.module.ts
├── assets/
│   └── themes/         # Theme CSS files
└── styles.scss         # Global styles
```

### Module Organization

- Group related functionality in feature modules
- Use lazy loading for feature modules
- Keep shared modules minimal
- Separate business logic from presentation

## Angular Patterns

### Component Structure

```typescript
@Component({
 selector: 'app-user-list',
 templateUrl: './user-list.component.html',
 styleUrls: ['./user-list.component.scss']
})
export class UserListComponent implements OnInit {
 // Properties
 users: User[] = [];
 loading = false;
 
 // Constructor with dependency injection
 constructor(
   private userService: UserService,
   private modalService: ModalService
 ) {}
 
 // Lifecycle hooks
 ngOnInit(): void {
   this.loadUsers();
 }
 
 // Public methods
 loadUsers(): void {
   this.loading = true;
   this.userService.getUsers()
     .subscribe({
       next: (users) => {
         this.users = users;
         this.loading = false;
       },
       error: (error) => {
         this.handleError(error);
         this.loading = false;
       }
     });
 }
 
 // Private methods
 private handleError(error: Error): void {
   // Error handling
 }
}
```

### Service Patterns

```typescript
@Injectable({
 providedIn: 'root'
})
export class UserService {
 constructor(private http: HttpClient) {}
 
 getUsers(): Observable<User[]> {
   return this.http.get<User[]>('/api/users');
 }
 
 createUser(user: User): Observable<User> {
   return this.http.post<User>('/api/users', user);
 }
}
```

### Dependency Injection

- Use constructor injection
- Prefer `providedIn: 'root'` for services
- Use interfaces for abstraction
- Keep dependencies minimal

## Testing Requirements

### Unit Tests

```typescript
describe('UserListComponent', () => {
 let component: UserListComponent;
 let fixture: ComponentFixture<UserListComponent>;
 let userService: jasmine.SpyObj<UserService>;
 
 beforeEach(async () => {
   const userServiceSpy = jasmine.createSpyObj('UserService', ['getUsers']);
   
   await TestBed.configureTestingModule({
     declarations: [UserListComponent],
     providers: [
       { provide: UserService, useValue: userServiceSpy }
     ]
   }).compileComponents();
   
   fixture = TestBed.createComponent(UserListComponent);
   component = fixture.componentInstance;
   userService = TestBed.inject(UserService) as jasmine.SpyObj<UserService>;
 });
 
 it('should load users on init', () => {
   const users = [{ id: '1', name: 'Test User' }];
   userService.getUsers.and.returnValue(of(users));
   
   component.ngOnInit();
   
   expect(userService.getUsers).toHaveBeenCalled();
   expect(component.users).toEqual(users);
 });
});
```

### Test Coverage

- Aim for 80%+ coverage on business logic
- Test critical user flows
- Test error handling
- Test edge cases
- Use mocks for external dependencies

## Documentation Standards

### Code Comments

- Document complex business logic
- Explain "why" not "what"
- Use JSDoc for public APIs
- Keep comments up-to-date

### Component Documentation

```typescript
/**
 * User list component displays a grid of users with filtering and actions.
 * 
 * Features:
 * - Pagination
 * - Search/filter
 * - User actions (edit, delete)
 * 
 * @component
 */
@Component({
 selector: 'app-user-list',
 templateUrl: './user-list.component.html'
})
export class UserListComponent {}
```

## CFW Integration

### Module Imports

```typescript
import { ButtonModule } from '@ucfw/components/button';
import { GridModule } from '@ucfw/components/grid';
import { AlertModule } from '@ucfw/components/alert';
import { UThemeModule } from '@ucfw/styles';

@NgModule({
 imports: [
   CommonModule,
   ButtonModule,
   GridModule,
   AlertModule,
   UThemeModule.forRoot({
     styleSheetContentRoot: 'assets/themes/'
   })
 ],
 declarations: [UserListComponent]
})
export class UserModule {}
```

## Best Practices

- Follow Angular style guide
- Use OnPush change detection when possible
- Implement proper error handling
- Use RxJS operators effectively
- Keep components focused and small
- Separate concerns (presentation vs business logic)
- Use TypeScript strict mode
- Follow CFW design system guidelines
- Write comprehensive tests
- Document complex logic

## Common Patterns

### Error Handling

```typescript
this.userService.getUsers()
 .pipe(
   catchError(error => {
     this.logger.error('Failed to load users', error);
     this.showError('Unable to load users. Please try again.');
     return of([]);
   })
 )
 .subscribe(users => this.users = users);
```

### Loading States

```typescript
loading = false;

loadData(): void {
 this.loading = true;
 this.dataService.getData()
   .pipe(finalize(() => this.loading = false))
   .subscribe(data => this.data = data);
}
```

### Form Handling

```typescript
form = this.fb.group({
 email: ['', [Validators.required, Validators.email]],
 name: ['', Validators.required]
});

onSubmit(): void {
 if (this.form.valid) {
   this.userService.createUser(this.form.value)
     .subscribe(user => this.handleSuccess(user));
 }
}
```

---


# Git Commit Instructions (Conventional Commits)

## Commit Message Format

Structure:
```
<type>(<scope>): <description> [<TICKET-NUMBER> /fixed]

[optional body]

[optional footer(s)]
```

## Types

- **feat**: a new feature
- **fix**: a bug fix
- **docs**: documentation only changes
- **style**: changes that do not affect the meaning of the code (formatting, missing semicolons, etc.)
- **refactor**: a code change that neither fixes a bug nor adds a feature
- **perf**: a code change that improves performance
- **test**: adding missing tests or correcting existing tests
- **build**: changes that affect the build system or external dependencies (Maven, npm, yarn)
- **ci**: changes to CI configuration files and scripts
- **chore**: other changes that don't modify src or test files

## Ticket Number

Always include the ticket number from your branch name:
- For HDEFECT tickets: `[HDEFECT-12345 /fixed]`
- For HFW tickets: `[HFW-5460 /fixed]`

### Extracting Ticket Number from Branch Name

Example branch name:
```
HFW-5460_provide_ORBIS_U_Platform_Metadata  ->  HFW-5460
```

Extract the ticket prefix and number from the beginning of the branch name.

## Examples

```bash
feat(api): add user authentication endpoint [HFW-5460 /fixed]

fix(ui): resolve null pointer exception in user profile [HDEFECT-789 /fixed]

docs(readme): update installation instructions [HFW-5460 /fixed]

refactor(service): simplify data validation logic [HFW-5460 /fixed]
```

## Guidelines

- Use the imperative mood in the description ("add" not "added")
- Don't capitalize the first letter of the description
- No period at the end of the description
- Keep the first line under 72 characters
- Add detailed explanation in the body if needed
- Reference breaking changes in the footer with:
  ```
  BREAKING CHANGE: <description>
  ```

## Complete Example

```
feat(auth): implement JWT token validation [HFW-5460 /fixed]

Add POST /api/auth/login endpoint with JWT token generation.
Includes input validation and error handling.

BREAKING CHANGE: Authentication now requires API key in header.
```

## Branch Naming

Follow Dedalus branch naming conventions:
- Feature branches: `HFW-<number>_<description>` or `HDEFECT-<number>_<description>`
- Use kebab-case for description: `HFW-5460_provide_platform_metadata`
- Extract ticket number from branch name for commit messages

---


# Logging with Emojis

Use emojis when writing log messages so that log levels and intent are easy to spot when scanning logs.

## When to Use Emojis

- **All log levels**: Prefix or include an emoji that matches the intent of the message
- **Structured logging**: Prefer a leading emoji in the message string so it appears in every line
- **Consistency**: Use the same emoji for the same kind of event across the codebase

## Recommended Emojis by Intent

| Intent / Level   | Emoji | Example use |
|------------------|-------|-------------|
| Error / failure  | 🔴 or ❌ | Exceptions, failed operations |
| Warning         | ⚠️ or 🟡 | Deprecations, fallbacks, recoverable issues |
| Info / success  | ℹ️ or ✅ | Startup, shutdown, key milestones |
| Debug           | 🔍 or 🐛 | Detailed state, trace data |
| HTTP / request  | 🌐 or 📡 | Incoming/outgoing requests |
| Database        | 🗄️ or 💾 | Queries, migrations, persistence |
| Security        | 🔒 or 🛡️ | Auth, validation, secrets |
| Performance     | ⚡ or 📊 | Timings, metrics |

Choose one set and use it consistently in the project.

## Examples

```typescript
// ❌ BAD - No emoji, harder to scan
logger.error('Failed to fetch data', { error });
logger.info('Server started on port 3000');
logger.warn('Cache miss for key', { key });

// ✅ GOOD - Emoji clarifies intent at a glance
logger.error('🔴 Failed to fetch data', { error });
logger.info('✅ Server started on port 3000');
logger.warn('⚠️ Cache miss for key', { key });
```

```python
# ❌ BAD
logger.error("Database connection failed: %s", e)
logger.info("Request completed in %d ms", duration)

# ✅ GOOD
logger.error("🔴 Database connection failed: %s", e)
logger.info("✅ Request completed in %d ms", duration)
```

## Guidelines

- **Placement**: Put the emoji at the start of the message string so it appears in log aggregation and tail output.
- **One per message**: Use a single, clear emoji per log line; avoid multiple or decorative emojis.
- **Structured fields**: Keep emojis in the message; do not put them in structured fields (e.g. `error`, `context`) unless the logging format expects it.
- **Sensitive data**: Never log secrets or PII; emoji usage does not change existing security rules for log content.
