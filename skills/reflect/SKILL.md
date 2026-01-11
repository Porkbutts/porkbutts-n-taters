---
name: reflect
description: Capture lessons from conversation after Claude made mistakes or needed correction. Trigger phrases include "reflect", "review our mistakes", "learn from this", "capture this lesson", "remember this for next time". Analyzes the conversation to extract actionable guidance and persists it to ~/.claude/lessons/ with triggers in ~/.claude/CLAUDE.md.
---

# Reflect

Analyze the current conversation to extract lessons from mistakes or corrections, then persist them as "if we were starting over" guidance for future sessions.

## Workflow

1. **Identify the problem**: Scan the conversation for where things went wrong - look for user corrections, error messages, failed attempts, or "actually, do X instead" moments

2. **Trace the resolution**: Follow the back-and-forth to understand how the issue was resolved - what did the user clarify? What fix worked?

3. **Draft the lesson**: Extract what you think the actionable insight is - frame it as "if we were starting over, here's the right approach"

4. **Validate with user**: Present your draft lesson and ask the user to confirm or correct it. This is critical because:
   - You may have misidentified the root cause (correlation vs causation)
   - Some "fixes" may have been red herrings that happened to work alongside the real fix
   - The user knows which insight is actually valuable to persist

   Ask something like: "Here's the lesson I extracted - is this the right takeaway, or did I miss the actual root cause?"

5. **Write and register**: Once validated:
   - Suggest filename `YYYY-MM-DD-<topic>.md` and confirm with user
   - Save to `~/.claude/lessons/` using the format in [lesson-template.md](references/lesson-template.md)
   - Add entry to Lessons table in `~/.claude/CLAUDE.md` (create table if needed - see format below)

## Edge Cases

- **No clear mistake**: If the user wants to capture a learning that wasn't from a mistake (e.g., "remember this approach"), still use the same format but frame "What to avoid" as the less-optimal alternative
- **Multiple lessons**: If multiple unrelated lessons emerge from one conversation, write them as separate files and validate each one individually with the user

## CLAUDE.md Format

Add a Lessons section to `~/.claude/CLAUDE.md` with a flat table mapping activities to lesson files:

```markdown
## Lessons

Before starting any task, scan this table for relevant lessons. Read the full file when a trigger matches what you're about to do.

| Consult when | Lesson |
|--------------|--------|
| Creating a new Expo project | [2025-01-10-expo-project-setup.md](lessons/2025-01-10-expo-project-setup.md) |
```

When adding a new lesson, append a row with:
- **Consult when**: Activity-based trigger describing when to read this (e.g., "Creating or upgrading an Expo project", "Setting up JWT authentication")
- **Lesson**: Relative link to the dated lesson file

## Tips for Good Lessons

- **Lead with the right approach**: The lesson should read like advice for someone starting fresh, not a debugging post-mortem
- **Be specific**: "Use `npx create-expo-app`" is better than "use the official scaffolding tool"
- **Name the anti-pattern explicitly**: Future Claude needs to recognize when it's about to do the wrong thing
- **Keep explanations brief**: Just enough context to understand why the right approach is right
- **One lesson per file**: Keep each lesson focused on a single insight
- **Write activity-based triggers**: Frame "Consult when" around what Claude is about to *do*, not what error it might *see*
