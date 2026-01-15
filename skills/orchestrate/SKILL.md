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
| Tasks | `docs/TASKS.md` | Invoke `/task-decomposition` skill |

Use a general agent (opus) to invoke each missing skill in order. Proceed automatically—each skill handles its own user confirmation.

## Resume Detection

On startup, introspect state to determine where to resume. This makes the skill idempotent—safe to run repeatedly.

### Check sequence:

```bash
# 1. Check planning artifacts
ls docs/PRD.md docs/ARCHITECTURE.md docs/TASKS.md 2>/dev/null

# 2. Check task specs
ls docs/tasks/task-*.md 2>/dev/null

# 3. Check for in-progress worktrees
git worktree list | grep '.worktrees/task-'

# 4. Check for unmerged task branches
git branch --list 'task/*'

# 5. Parse TASKS.md for progress markers
grep -E '^\s*- \[(x| |🚧)\]' docs/TASKS.md
```

### Resume logic:

| State | Resume Point |
|-------|--------------|
| No `docs/PRD.md` | Start Phase 1 |
| No `docs/ARCHITECTURE.md` | Phase 1: architecture skill |
| No `docs/TASKS.md` | Phase 1: task-decomposition skill |
| No `docs/tasks/*.md` | Start Phase 2 |
| Task marked `🚧` in TASKS.md | Resume that task (check worktree exists) |
| Worktree exists but task not marked | Mark as `🚧`, resume implementation |
| Task `[x]` but branch still exists | Just needs merge (step 5) |
| Branch exists, worktree missing | Recreate worktree, resume |
| All tasks `[x]`, no task branches | Complete—nothing to do |

### In-progress task recovery:

If a worktree exists at `.worktrees/task-<id>`:
1. Check if branch has uncommitted changes → continue implementation
2. Check if branch has commits ahead of main → needs review or merge
3. Check task-spec for `## Review Feedback` section → address feedback

Report detected state to user before proceeding:
```
Detected state:
- Planning: Complete (PRD, Architecture, Tasks exist)
- Task specs: 12 generated
- Progress: 5/12 tasks complete
- In-progress: task-2.1.3 (worktree exists, has commits)
- Resuming from: task-2.1.3 code review
```

## Workflow

```
┌─────────────────────────────────────────────────────────────────┐
│                    PHASE 0: RESUME DETECTION                    │
├─────────────────────────────────────────────────────────────────┤
│  Introspect files, worktrees, branches → determine resume point │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                    PHASE 1: PLANNING                            │
├─────────────────────────────────────────────────────────────────┤
│  PRD → Architecture → Tasks (invoke skills as needed)          │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                    PHASE 2: TASK SPEC GENERATION                │
├─────────────────────────────────────────────────────────────────┤
│  Launch task-spec-generator agent → docs/tasks/task-<id>.md     │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                    PHASE 3: IMPLEMENTATION LOOP                 │
├─────────────────────────────────────────────────────────────────┤
│  For each story (in order):                                     │
│    For each task (respecting dependencies):                     │
│      1. Launch task-implementer agent                           │
│      2. Launch code-reviewer agent                              │
│      3. If changes requested → re-run task-implementer          │
│      4. Repeat until approved                                   │
│      5. Merge feature branch to main                            │
│      6. Update progress in TASKS.md                             │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                    PHASE 4: STORY COMPLETION                    │
├─────────────────────────────────────────────────────────────────┤
│  Verify all acceptance criteria met, update TASKS.md            │
└─────────────────────────────────────────────────────────────────┘
```

## Phase 2: Task Spec Generation

Launch the **task-spec-generator** agent to create individual task files:

```
Task agent: task-spec-generator
Prompt: "Generate task specs from docs/TASKS.md"
```

This creates `docs/tasks/task-<id>.md` for each task (e.g., `task-1.1.1.md`, `task-2.3.2.md`).

## Phase 3: Implementation Loop

Process epics and stories in the order specified in `docs/TASKS.md` "Implementation Order" section.

### For each task:

1. **Launch task-implementer agent:**
   ```
   Task agent: task-implementer
   Prompt: "Implement task <id> per docs/tasks/task-<id>.md"
   ```

2. **Launch code-reviewer agent:**
   ```
   Task agent: code-reviewer
   Prompt: "Review task/<id> in worktree .worktrees/task-<id> against docs/tasks/task-<id>.md"
   ```

3. **Handle review outcome:**
   - **APPROVED**: Proceed to step 4
   - **REQUEST CHANGES**: Re-launch task-implementer (it reads feedback from task-spec)

4. **Update progress:** Mark task `[x]` in `docs/TASKS.md` (signals "approved, ready to merge")

5. **Merge to main:** (use `--no-ff` to preserve branch history)
   ```bash
   git checkout main
   git merge task/<id> --no-ff -m "Merge task/<id>: [title]"
   git worktree remove .worktrees/task-<id>
   git branch -d task/<id>
   ```

### Parallel Execution

Tasks within a story MAY run in parallel if:
- No dependencies between them (check Dependencies table in TASKS.md)
- They don't modify the same files

Launch multiple task-implementer agents simultaneously for independent tasks. Each operates in its own worktree.

**Merge conflict handling:** If conflicts occur during merge:
1. Resolve conflicts manually
2. Run tests to verify resolution
3. Complete the merge

## Phase 4: Story Completion

After all tasks in a story complete:

1. Verify all story acceptance criteria are met
2. Mark the story complete in `docs/TASKS.md`
3. Proceed to next story

After all stories in an epic complete:
1. Mark the epic complete in `docs/TASKS.md`
2. Optionally: create a release/tag

## Progress Tracking

Keep `docs/TASKS.md` updated throughout:
- `[ ]` → `🚧` when task starts
- `🚧` → `[x]` when task merges

## Error Handling

| Situation | Action |
|-----------|--------|
| Task-implementer blocked | Document blocker in task-spec, skip to next task, return later |
| Tests won't pass after 3 review cycles | Escalate to user for manual intervention |
| Merge conflicts unresolvable | Pause parallel execution, resolve sequentially |
| Missing dependency | Implement dependency first, then resume |
