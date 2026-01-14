---
name: task-decomposition
description: Break down PRD and Architecture into implementable engineering tasks. Use when user wants to create a task list, plan implementation work, decompose features into stories and tasks, or needs to translate requirements into actionable engineering work. Reads from docs/PRD.md and docs/ARCHITECTURE.md, outputs docs/TASKS.md.
---

# Task Decomposition

Transform a PRD and Architecture document into a structured task list with epics, user stories, and atomic engineering tasks. Read `docs/PRD.md` and `docs/ARCHITECTURE.md`, analyze the work required, and produce `docs/TASKS.md` with tasks that are independently implementable and testable.

## Workflow

```
START
  │
  ▼
┌─────────────────────────────┐
│ Read docs/PRD.md            │ ◄── Load requirements
│ Read docs/ARCHITECTURE.md   │ ◄── Load technical design
└──────────┬──────────────────┘
           │
           ▼
┌─────────────────────────────┐
│ Identify Epics              │ ◄── Group by major feature areas
└──────────┬──────────────────┘
           │
           ▼
┌─────────────────────────────┐
│ Break into User Stories     │ ◄── Define user-facing value units
└──────────┬──────────────────┘
           │
           ▼
┌─────────────────────────────┐
│ Decompose into Tasks        │ ◄── Atomic, testable engineering work
└──────────┬──────────────────┘
           │
           ▼
┌─────────────────────────────┐
│ Confirm with user           │ ◄── Review structure, get approval
└──────────┬──────────────────┘
           │
           ▼
┌─────────────────────────────┐
│ Generate TASKS.md           │ ◄── Write to docs/TASKS.md
└─────────────────────────────┘
```

## Step 1: Read Input Documents

Read both documents to understand:
- **From PRD**: User scenarios, acceptance criteria, scope boundaries, roles
- **From Architecture**: Tech stack, directory structure, key abstractions, data flow

If either file is missing, ask the user to provide it or suggest using the appropriate skill first (product-design for PRD, architecture for ARCHITECTURE.md).

## Step 2: Identify Epics

Group work into 3-7 epics based on:
- Major feature areas from the PRD
- Architectural boundaries (frontend, backend, integrations)
- User roles or workflows

Each epic should represent a cohesive chunk of functionality that could be released independently.

## Step 3: Break into User Stories

For each epic, create user stories that:
- Deliver user-facing value
- Are small enough to complete in 1-3 days
- Follow the format: "As a [role], I can [action] so that [benefit]"
- Include acceptance criteria from the PRD

## Step 4: Decompose into Engineering Tasks

For each user story, create atomic tasks. Each task MUST:

**Be small and focused:**
- Touch 1-3 files maximum
- Completable in 1-4 hours
- Single responsibility

**Be independently testable:**
- Can be verified without other tasks complete
- Has clear pass/fail criteria
- Includes specific test approach

**Have clear acceptance criteria:**
- Defines "done" unambiguously
- References specific files/functions
- Includes edge cases to handle

**Specify file paths:**
- List exact files to create or modify
- Use paths from ARCHITECTURE.md directory structure

## Step 5: Confirm with User

Before generating, summarize:
- Number of epics, stories, and tasks
- Any ambiguities or assumptions made
- Suggested implementation order

Ask if they're ready to proceed or want adjustments.

## Step 6: Generate TASKS.md

Write to `docs/TASKS.md` using the template below.

## Task Document Template

```markdown
# [Product Name] - Implementation Tasks

## Overview

- **Total Epics**: [N]
- **Total Stories**: [N]
- **Total Tasks**: [N]
- **Estimated Scope**: [Brief complexity assessment]

## Task Legend

- [ ] Not started
- [x] Complete
- 🚧 In progress

---

## Epic 1: [Epic Name]

[1-2 sentence description of this feature area]

### Story 1.1: [User Story Title]

**As a** [role], **I can** [action] **so that** [benefit].

**Acceptance Criteria:**
- [ ] [Criterion from PRD]
- [ ] [Criterion from PRD]

#### Tasks

##### Task 1.1.1: [Task Title]

**Files:** `path/to/file1.ts`, `path/to/file2.ts`

**Description:** [What to implement]

**Acceptance Criteria:**
- [ ] [Specific, testable criterion]
- [ ] [Specific, testable criterion]

**Testing:** [How to verify - e.g., "Run `npm test src/auth`" or "Manually verify login flow"]

---

##### Task 1.1.2: [Task Title]

[Continue pattern...]

---

### Story 1.2: [Next Story]

[Continue pattern...]

---

## Epic 2: [Epic Name]

[Continue pattern...]

---

## Implementation Order

Suggested sequence based on dependencies:

1. **[Epic/Story]** - [Why first - e.g., "Sets up core infrastructure"]
2. **[Epic/Story]** - [Why next - e.g., "Depends on auth from #1"]
3. [Continue...]

## Dependencies

| Task | Depends On | Reason |
|------|------------|--------|
| [Task ID] | [Task ID(s)] | [Why] |

## Notes

- [Any assumptions made during decomposition]
- [Risks or areas needing clarification]
```

## Task Quality Checklist

Before finalizing each task, verify:

- [ ] **Atomic**: Single clear objective
- [ ] **Scoped**: 1-3 files, 1-4 hours
- [ ] **Testable**: Clear verification method
- [ ] **Independent**: Can be done without completing other tasks (may depend on interfaces, not implementations)
- [ ] **Specific**: References exact file paths from architecture

## Example Task Decomposition

**Story**: As a user, I can log in with email/password so that I can access my account.

**Bad decomposition:**
```
- [ ] Implement authentication
```
Too vague, touches many files, unclear when done.

**Good decomposition:**
```
##### Task 2.1.1: Create auth schema and types
**Files:** `src/lib/types/auth.ts`, `prisma/schema.prisma`
**Description:** Define User model in Prisma schema and TypeScript types for auth flows.
**Acceptance Criteria:**
- [ ] User model has id, email, passwordHash, createdAt, updatedAt
- [ ] AuthRequest and AuthResponse types exported
- [ ] `npx prisma validate` passes
**Testing:** Run `npx prisma validate` and `tsc --noEmit`

##### Task 2.1.2: Create login API endpoint
**Files:** `src/app/api/auth/login/route.ts`
**Description:** POST endpoint that validates credentials and returns session token.
**Acceptance Criteria:**
- [ ] Returns 200 + token on valid credentials
- [ ] Returns 401 on invalid email
- [ ] Returns 401 on wrong password
- [ ] Rate limited to 5 attempts per minute
**Testing:** `curl -X POST localhost:3000/api/auth/login -d '{"email":"test@test.com","password":"test"}'`

##### Task 2.1.3: Create login form component
**Files:** `src/components/auth/LoginForm.tsx`
**Description:** Form with email/password inputs, validation, and submit handler.
**Acceptance Criteria:**
- [ ] Email field with validation
- [ ] Password field with show/hide toggle
- [ ] Loading state during submission
- [ ] Error display for failed attempts
**Testing:** Visual verification at /login, test with valid/invalid inputs
```

## Guidelines

**Match granularity to complexity**: Simple CRUD might be one task. Complex business logic needs multiple.

**Front-load infrastructure**: Schema, types, and setup tasks come first.

**Identify natural boundaries**: API endpoint, UI component, and database migration are often separate tasks.

**Make dependencies explicit**: If Task B needs Task A's types, say so.

**Include the unsexy work**: Migrations, error handling, loading states, and edge cases are tasks too.
