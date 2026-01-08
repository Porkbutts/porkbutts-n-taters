# Create Task Specification

<!--
  TEMPLATE: Example slash command for creating new task specifications.
  Customize or replace with commands relevant to your workflow.

  Usage: /create-task <task-name>
  Example: /create-task add-user-authentication
-->

Create a new task specification for: $ARGUMENTS

## Instructions

1. Determine the next task number by checking existing files in `docs/tasks/`
2. Create a new file `docs/tasks/NNN-$ARGUMENTS.md` where NNN is the zero-padded number
3. Use this template structure:

```markdown
# Task NNN: [Task Title]

## Overview
Brief description of what this task accomplishes.

## Background
Context and motivation for this task. Reference relevant:
- PRD sections from `docs/10-prd.md`
- User stories from `docs/40-backlog.md`
- Technical design from `docs/30-tech-design.md`

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Technical Approach
Suggested implementation approach.

## Edge Cases
- Edge case 1
- Edge case 2

## Testing Requirements
- Unit tests for...
- Integration tests for...

## Out of Scope
What this task explicitly does NOT include.
```

4. Fill in the template based on project context and requirements
