# Create Backlog

Generate a product backlog from the PRD.

## Setup

1. Read the PRD from `$ARGUMENTS` (default: `docs/10-prd.md`)
2. Extract all requirements (P0 and P1)
3. Identify target users/personas

## Process

### Step 1: Analyze Requirements

From the PRD, identify:
- Must-have features (P0)
- Nice-to-have features (P1)
- User personas and their goals
- Success metrics

### Step 2: Create User Stories

For each requirement, create user stories in this format:

```
As a [persona],
I want to [action],
So that [benefit].
```

### Step 3: Define Acceptance Criteria

For each user story, define specific acceptance criteria that are:
- Testable
- Unambiguous
- Complete

### Step 4: Estimate & Prioritize

Assign to each story:
- **Priority**: P0 (must-have) or P1 (nice-to-have)
- **Size**: S (small), M (medium), L (large), XL (extra-large)
- **Dependencies**: Other stories this depends on

## Output

Generate the backlog at `docs/40-backlog.md` using this structure:

```markdown
# Product Backlog

## Overview
[Product name] - Backlog generated from PRD

## Epics

### Epic 1: [Name]
[Brief description of this feature area]

### Epic 2: [Name]
[Brief description]

## User Stories

### P0 - Must Have

#### [ID]: [Story Title]
**Epic**: [Epic name]
**Size**: [S/M/L/XL]
**Dependencies**: [None or story IDs]

> As a [persona],
> I want to [action],
> So that [benefit].

**Acceptance Criteria**:
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

---

### P1 - Nice to Have

#### [ID]: [Story Title]
...

## Story Map

| Epic | P0 Stories | P1 Stories |
|------|------------|------------|
| | | |

## Release Planning

### MVP (P0 Complete)
Stories: [list of story IDs]

### V1.1 (Selected P1)
Stories: [list of story IDs]

## Open Questions
- Questions that arose during backlog creation
```

## Instructions

1. Read the PRD thoroughly
2. Group related requirements into epics
3. Create user stories with clear acceptance criteria
4. Assign priorities based on PRD (P0/P1)
5. Estimate sizes relative to each other
6. Identify dependencies between stories
7. Present draft backlog for review
8. Write final backlog to `docs/40-backlog.md`
