# Visual Verification Patterns

Screenshot-first patterns for common UI verification scenarios.

## Form Flows

### Form Submission
```
1. browser_navigate to form page
2. browser_take_screenshot(filename="form-empty.png", fullPage=true)
3. browser_snapshot to get field refs
4. browser_fill_form with test data
5. browser_take_screenshot(filename="form-filled.png", fullPage=true)
6. browser_click submit button
7. browser_wait_for success indicator or page change
8. browser_take_screenshot(filename="form-submitted.png", fullPage=true)

Visual checks:
- Form layout correct before/after fill
- Validation errors visible if triggered
- Success state clearly displayed
```

### Form Validation
```
1. browser_take_screenshot(filename="validation-before.png")
2. Submit with invalid data
3. browser_take_screenshot(filename="validation-errors.png")
4. Verify error messages visible in screenshot

Visual checks:
- Error styling (red borders, icons)
- Error message positioning
- Field highlighting
```

## Navigation Flows

### Page Navigation
```
1. browser_take_screenshot(filename="nav-source.png")
2. browser_click navigation element
3. browser_wait_for(time=1) for transition
4. browser_take_screenshot(filename="nav-destination.png")

Visual checks:
- Correct page loaded
- Active nav state updated
- Content changed appropriately
```

### Modal/Dialog
```
1. browser_take_screenshot(filename="modal-closed.png")
2. browser_click trigger element
3. browser_wait_for modal content
4. browser_take_screenshot(filename="modal-open.png")
5. Interact with modal
6. browser_take_screenshot(filename="modal-action.png")
7. Close modal
8. browser_take_screenshot(filename="modal-closed-after.png")

Visual checks:
- Modal overlay covers background
- Modal centered/positioned correctly
- Background appropriately dimmed
- Modal content readable
```

## Data Display

### List/Table View
```
1. browser_navigate to list page
2. browser_take_screenshot(filename="list-initial.png", fullPage=true)
3. Apply filter/sort if testing
4. browser_take_screenshot(filename="list-filtered.png", fullPage=true)

Visual checks:
- Data rows rendered
- Columns aligned
- Empty states handled
- Pagination visible if applicable
```

### Search/Filter
```
1. browser_take_screenshot(filename="search-before.png")
2. browser_type search query
3. browser_wait_for results
4. browser_take_screenshot(filename="search-results.png")

Visual checks:
- Results match query
- No results state if empty
- Loading states visible during fetch
```

## Interactive Elements

### Dropdown/Select
```
1. browser_take_screenshot(filename="dropdown-closed.png")
2. browser_click dropdown trigger
3. browser_take_screenshot(filename="dropdown-open.png")
4. browser_select_option or browser_click option
5. browser_take_screenshot(filename="dropdown-selected.png")

Visual checks:
- Options visible when open
- Selected state shown
- Dropdown closes after selection
```

### Toggle/Checkbox
```
1. browser_take_screenshot(filename="toggle-off.png")
2. browser_click toggle
3. browser_take_screenshot(filename="toggle-on.png")

Visual checks:
- Clear visual distinction between states
- Animation smooth (compare screenshots)
```

## Responsive/Layout

### Viewport Testing
```
1. browser_resize(width=1920, height=1080)
2. browser_take_screenshot(filename="layout-desktop.png", fullPage=true)
3. browser_resize(width=768, height=1024)
4. browser_take_screenshot(filename="layout-tablet.png", fullPage=true)
5. browser_resize(width=375, height=812)
6. browser_take_screenshot(filename="layout-mobile.png", fullPage=true)

Visual checks:
- Layout adapts to viewport
- No horizontal overflow
- Touch targets adequate on mobile
- Navigation transforms (hamburger menu)
```

## Auth Detection

### Identifying Auth Type
```
browser_snapshot to get page content and classify:

Google Account Picker (auto-handle):
- Text: "Choose an account", "Use another account"
- Account list with email addresses and avatars
- URLs: accounts.google.com/AccountChooser, accounts.google.com/o/oauth2

If detected:
1. browser_take_screenshot(filename="auth-google-select.png")
2. browser_click the first account in the list
3. browser_wait_for(time=2) for redirect
4. browser_take_screenshot(filename="auth-google-complete.png")
5. Continue verification

Credential-based Login (defer to user):
- Text: "Sign in", "Log in", "Login", "Sign up"
- Text: "Create account", "Register"
- Text: "Session expired", "Please authenticate"
- Text: "Enter your password", "Enter your email"
- Elements: password fields, email+password form
- URLs: /login, /signin, /auth

If detected:
1. browser_take_screenshot(filename="auth-required.png")
2. Notify user with options
3. Wait for user response
```

## Error States

### Error Page Detection
```
browser_snapshot looking for:
- HTTP status in page (404, 500, etc.)
- Text: "Error", "Not found", "Something went wrong"
- Empty/broken layouts

If detected:
1. browser_take_screenshot(filename="error-state.png", fullPage=true)
2. Record as failure
3. Include screenshot in report
```

## Timing Considerations

- **After navigation**: wait 1-2 seconds for page load
- **After form submit**: wait for success/error indicator
- **After dynamic updates**: wait for loading spinners to disappear
- **Animations**: wait for completion before screenshot
- **API calls**: use browser_wait_for with expected text

## Screenshot Best Practices

1. **Consistent naming**: `{step}-{action}-{state}.png`
2. **Full page for layout**: `fullPage: true`
3. **Element shots for detail**: specify `ref` and `element`
4. **Capture failures immediately**: don't navigate away first
5. **Include context**: capture enough of the page to understand state
