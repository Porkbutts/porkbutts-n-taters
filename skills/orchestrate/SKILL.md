---
name: orchestrate
description: End-to-end project orchestration from idea to implementation. Use when user wants to build a complete project, implement an MVP, or says "build this app/feature". Coordinates product-design, architecture, task-decomposition skills, then delegates to task-spec-generator, task-implementer, and code-reviewer agents for execution. Resumable—introspects filesystem and git state to pick up where it left off if interrupted.
---

# Orchestrate

Coordinate the full development lifecycle: requirements → architecture → tasks → implementation → review → merge.

## Prerequisites Check

Before starting, verify which artifacts exist:

| Artifact | Path | If Missing |
|----------|------|------------|
| PRD | `docs/PRD.md` | Invoke `/product-design` skill |
| Architecture | `docs/ARCHITECTURE.md` | Invoke `/architecture` skill |
| Brand Guidelines | `docs/BRAND-GUIDELINES.md` | Invoke `/frontend-design` skill |
| Tasks | `docs/TASKS.md` | Invoke `/task-decomposition` skill |

Invoke each missing skill in order. After Phase 1 is complete, clear context before proceeding to Phase 2.

## Resume Detection

On startup, introspect state to determine where to resume. `docs/TASKS.md` is the sole source of truth for progress. If any partial work exists (worktrees, unmerged task branches), clean it up before proceeding.

### Check sequence:

```bash
# 1. Check planning artifacts
ls docs/PRD.md docs/ARCHITECTURE.md docs/BRAND-GUIDELINES.md docs/TASKS.md 2>/dev/null

# 2. Check task specs
ls docs/tasks/task-*.md 2>/dev/null

# 3. Clean up any leftover worktrees and branches from interrupted runs
git worktree list | grep '.worktrees/task-'
git branch --list 'task/*'

# 4. Parse TASKS.md for progress
grep -E '^\s*- \[(x| )\]' docs/TASKS.md
```

### Cleanup:

Remove any worktrees and branches from incomplete tasks before resuming. Only tasks marked `[x]` in `docs/TASKS.md` are considered done—everything else starts fresh.

### Resume logic:

| State | Resume Point |
|-------|--------------|
| No `docs/PRD.md` | Start Phase 1 |
| No `docs/ARCHITECTURE.md` | Phase 1: architecture skill |
| No `docs/BRAND-GUIDELINES.md` | Phase 1: frontend-design skill |
| No `docs/TASKS.md` | Phase 1: task-decomposition skill |
| No `docs/tasks/*.md` | Start Phase 2 |
| All tasks `[x]` | Complete—nothing to do |
| Otherwise | Resume Phase 3 from first unchecked task |

Report detected state to user before proceeding:
```
Detected state:
- Planning: Complete (PRD, Architecture, Brand Guidelines, Tasks exist)
- Task specs: 12 generated
- Progress: 5/12 tasks complete
- Resuming from: task-2.1.3
```

## Workflow

```
Phase 0: Resume Detection
  → Introspect files, worktrees, branches to find resume point

Phase 1: Planning
  → PRD → Architecture → Brand Guidelines → Tasks (invoke skills as needed)

Phase 2: Task Spec Generation
  → Launch task-spec-generator → creates docs/tasks/task-<id>.md

Phase 3: Implementation Loop
  For each task (in dependency order):
    1. Launch task-implementer
    2. Launch code-reviewer
    3. If REQUEST CHANGES → loop back to step 1
    4. Verify build/tests pass
    5. Merge to main, cleanup worktree, push
    6. Mark [x] in TASKS.md

Phase 4: Completion
  → All tasks done, optionally tag release
```

## Phase 2: Task Spec Generation

Launch the **task-spec-generator** agent to create individual task files:

```
Task agent: task-spec-generator
Prompt: "Generate task specs from docs/TASKS.md"
```

This creates `docs/tasks/task-<id>.md` for each task (e.g., `task-1.1.1.md`, `task-2.3.2.md`).

## Phase 3: Implementation Loop

Process tasks in the order specified in `docs/TASKS.md`.

### For each task:

1. **Launch task-implementer:**
   ```
   Agent: task-implementer
   Prompt: "Implement docs/tasks/task-<id>.md"
   ```

2. **Merge and cleanup:**
    Merge the branch, delete the worktree.

3. **Mark complete:** Change `[ ]` to `[x]` in `docs/TASKS.md`

### Parallel Execution

Tasks within a story MAY run in parallel if:
- No dependencies between them (check Dependencies table in TASKS.md)
- They don't modify the same files

Launch multiple task-implementer agents simultaneously for independent tasks. Each operates in its own worktree.

**Merge conflict handling:** If conflicts occur during merge:
1. Resolve conflicts manually
2. Run tests to verify resolution
3. Complete the merge

## Phase 4: Completion

When all tasks are merged:
1. Verify acceptance criteria in PRD are met
2. Optionally create a release tag

## Error Handling

| Situation | Action |
|-----------|--------|
| Task-implementer blocked | Document blocker in task-spec, skip to next task, return later |
| Tests won't pass after 3 review cycles | Escalate to user for manual intervention |
| Merge conflicts unresolvable | Pause parallel execution, resolve sequentially |
| Missing dependency | Implement dependency first, then resume |
