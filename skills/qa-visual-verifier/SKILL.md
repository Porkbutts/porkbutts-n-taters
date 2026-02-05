---
name: qa-visual-verifier
description: Visual QA verification skill using Playwright MCP for screenshot-based testing of PRs and user stories. Use when verifying implemented features match task specifications, testing user flows visually, checking for visual bugs, or validating acceptance criteria from docs/TASKS.md. Triggers on "verify this PR", "QA this feature", "visual test", "check the UI", "screenshot test", "verify task X". Supports both localhost dev servers and remote URLs. Auto-selects Google accounts; pauses for user assistance only on credential-based login flows.
---

# QA Visual Verifier

Screenshot-first verification of PRs and user stories using Playwright MCP. Visual bugs are what humans see—DOM snapshots don't tell the full story.

## Core Philosophy

1. **Screenshots over DOM inspection** - Take screenshots at every meaningful step to catch visual regressions
2. **Human-like verification** - Navigate flows as a user would, visually confirming each step
3. **Graceful auth handling** - Auto-select Google accounts; only pause for credential-based login
4. **Flexible targets** - Works against localhost dev servers or remote URLs

## Workflow

### 1. Parse Task Specification

Read the task file from `docs/tasks/task-<id>.md` or `docs/TASKS.md`. Extract:

- **User story**: The scenario being implemented
- **Acceptance criteria**: Specific conditions to verify
- **Test flows**: Step-by-step user interactions

If user specifies a PR number, use `gh pr view <number>` to identify affected files and infer the relevant task.

### 2. Gather Test Context

Before starting verification, collect:

| Item | Source | Default |
|------|--------|---------|
| **Target URL** | User-provided | `http://localhost:3000` |
| **Task/PR** | User-specified | Ask user |
| **Auth required?** | Task spec or inference | Assume no |
| **Screenshot dir** | User preference | `./qa-screenshots/` |

### 3. Visual Verification Loop

For each acceptance criterion:

```
1. SCREENSHOT: Capture baseline state
   browser_take_screenshot(filename="step-N-before-ACTION.png")

2. ACTION: Perform interaction
   browser_click/type/navigate as needed

3. WAIT: Allow page to settle (if dynamic content)
   browser_wait_for(time=1) or wait for specific text

4. SCREENSHOT: Capture result state
   browser_take_screenshot(filename="step-N-after-ACTION.png")

5. VERIFY: Visual inspection of screenshot
   - Does the UI look correct?
   - Are expected elements visible?
   - Any visual anomalies?

6. RECORD: Log result with screenshot references
```

### 4. Authentication Handling

When encountering an auth screen, use `browser_snapshot` to determine the type:

**Type A: Google Account Selection (handle automatically)**

If the page shows a Google account picker (e.g., "Choose an account", list of Google accounts/emails), simply click the first account and continue. Do NOT ask the user for help.

```
1. browser_snapshot to confirm it's an account picker
2. browser_take_screenshot(filename="auth-google-select.png")
3. browser_click the first account option
4. browser_wait_for(time=2) for redirect
5. browser_take_screenshot(filename="auth-google-complete.png")
6. Continue with verification flow
```

**Type B: Credential-based Login (defer to user)**

If the page requires entering a username/email and password, pause and ask the user:

```markdown
## Auth Required

I've encountered a credential-based login screen at [URL].

**Screenshot:** auth-required.png

**Options:**
1. **Manual login**: I'll wait while you log in via the browser, then continue
2. **Skip auth flows**: Mark auth-required tests as SKIPPED
3. **Provide credentials**: Share test credentials to proceed

Please respond with your choice or complete the login manually.
```

**Detection indicators:**
- **Auto-handle**: "Choose an account", account avatar list, Google account picker UI
- **Defer to user**: Login forms with email/password fields, "Enter your password" prompts, 401/403 error pages, "Session expired" messages

### 5. Screenshot Strategy

**When to screenshot:**

| Trigger | Filename Pattern | Purpose |
|---------|------------------|---------|
| Before any action | `{criterion}-before-{action}.png` | Baseline |
| After action completes | `{criterion}-after-{action}.png` | Verification |
| On failure | `{criterion}-FAIL.png` | Evidence |
| Unexpected state | `{criterion}-unexpected-{desc}.png` | Debug |
| Auth wall encountered | `auth-required-{page}.png` | User assistance |

**Screenshot settings:**
- Prefer `fullPage: true` for layout verification
- Use element screenshots for component-level checks
- PNG format for quality

### 6. Generate Visual Report

Output a markdown report with embedded screenshot references:

```markdown
# Visual QA Report

**Task:** [task ID or PR number]
**URL:** [target URL]
**Date:** [timestamp]
**Screenshots:** [directory path]

## Summary
- Passed: X
- Failed: Y
- Skipped: Z (auth required)

## Visual Verification Results

### 1. [Acceptance Criterion]

**Status:** PASS/FAIL/SKIP

**Flow:**
1. Navigated to /page
   ![Before](screenshots/1-before-navigate.png)
2. Clicked "Submit" button
   ![After](screenshots/1-after-click.png)

**Visual Check:** [Description of what was verified visually]
```

## Playwright Tools Usage

### Primary Tools (Screenshot-First)

| Tool | Use Case |
|------|----------|
| `browser_take_screenshot` | **Primary verification** - capture visual state |
| `browser_navigate` | Go to URLs |
| `browser_click` | Interact with elements |
| `browser_type` | Enter text |
| `browser_wait_for` | Wait for page updates |

### Secondary Tools (When Needed)

| Tool | Use Case |
|------|----------|
| `browser_snapshot` | Get element refs for interaction, detect auth walls |
| `browser_fill_form` | Complete multi-field forms |
| `browser_select_option` | Dropdown selections |

## Verification Patterns

See [references/visual-patterns.md](references/visual-patterns.md) for detailed patterns.

## Example Session

**User:** "Verify task 3.1 against localhost:5173"

**Flow:**
1. Read `docs/tasks/task-3.1.md`
2. Extract acceptance criteria
3. `browser_navigate` to `http://localhost:5173`
4. `browser_take_screenshot` - baseline
5. For each criterion:
   - Screenshot before
   - Perform actions
   - Screenshot after
   - Visually verify
   - Record result
6. If auth encountered: auto-select Google account, or pause for credential login
7. Generate report with all screenshots
