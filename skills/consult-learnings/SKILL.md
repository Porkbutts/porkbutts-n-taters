---
name: consult-learnings
description: Proactively consult before starting any implementation task to check for relevant learnings. Invoke at the start of planning phases, when scoping work, or before writing code to avoid known pitfalls and apply lessons from past sessions.
---

# Consult Learnings

Before starting implementation, check for relevant learnings that apply to the work at hand.

## Workflow

1. **Identify the task type**: What kind of work are you about to do? (e.g., setting up a project, writing tests, configuring auth, creating components)

2. **Check the learnings index**: Read the INDEX.md file to scan for relevant learnings:
   - **Project learnings**: `.claude/learnings/INDEX.md` - context-specific to this codebase
   - **Personal learnings**: `~/.claude/learnings/INDEX.md` - broadly applicable patterns

3. **Read matching learnings**: When a "Consult when" trigger matches your task, read the full learning file before proceeding

4. **Apply the guidance**: Follow "The right approach" and avoid the anti-patterns described

## When to Invoke

Invoke this skill when:
- Starting a new feature or component
- Setting up project infrastructure (build tools, testing, CI)
- Working with frameworks or libraries that have known gotchas
- Doing anything that feels like it could have hidden complexity

## Note on Locations

This skill can be installed in two places:
- **Personal** (`~/.claude/skills/consult-learnings/`): Reads from `~/.claude/learnings/`
- **Project** (`.claude/skills/consult-learnings/`): Reads from `.claude/learnings/`

Both can coexist - check both indexes when available.
