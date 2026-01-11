---
name: reflect
description: Capture lessons from conversation after Claude made mistakes or needed correction. Trigger phrases include "reflect", "review our mistakes", "review what went wrong", "learn from this", "capture this lesson", "remember this for next time", or any request to analyze and persist corrections from the current conversation. Analyzes the conversation to extract what went wrong, how it was resolved, and actionable guidance for future sessions. Writes lessons to ~/.claude/lessons/ and updates ~/.claude/CLAUDE.md with triggers.
---

# Reflect

Analyze the current conversation to extract lessons from mistakes or corrections, then persist them as "if we were starting over" guidance for future sessions.

## Workflow

1. **Identify the problem**: Scan the conversation for where things went wrong - look for user corrections, error messages, failed attempts, or "actually, do X instead" moments

2. **Trace the resolution**: Follow the back-and-forth to understand how the issue was resolved - what did the user clarify? What fix worked?

3. **Synthesize the lesson**: Extract the actionable insight - frame it as "if we were starting over, here's the right approach" not "here's how we fixed a mistake"

4. **Confirm the filename**: Suggest `YYYY-MM-DD-<topic>.md` and confirm with the user

5. **Write the lesson**: Save to `~/.claude/lessons/` using the format below

6. **Update CLAUDE.md**: Add an entry to the Lessons table in `~/.claude/CLAUDE.md` with an activity-based trigger so Claude consults this lesson proactively during planning. Create the table if it doesn't exist (see CLAUDE.md Format below)

## Lesson Format

Frame the lesson as "if we were starting over, here's the right approach"—lead with what to do, not what went wrong.

```markdown
# <Clear, actionable title - state the right approach>

## Consult when
<Activity-based trigger - what task should prompt reading this?>

## The right approach
<What to do from the start. Be specific: commands, patterns, tools. Write this as if advising someone who hasn't started yet.>

## What to avoid (and why)
<The anti-pattern that leads to problems, plus brief explanation of what goes wrong. Name the anti-pattern explicitly so it's recognizable.>
```

## Example

File: `~/.claude/lessons/2025-01-10-expo-project-setup.md`

```markdown
# Use create-expo-app for new Expo projects

## Consult when
Creating a new Expo project, initializing a React Native app with Expo, or setting up project configuration.

## The right approach
Use `npx create-expo-app` to scaffold new projects. This automatically handles:
- SDK version alignment with Expo Go
- Babel preset configuration
- Required asset files (icons, splash screens)
- Compatible dependency versions

Don't manually assemble the project structure—let the scaffolding tool do it.

## What to avoid (and why)
Manually writing package.json and app.json for Expo projects. Expo has tight coupling between SDK version, babel preset, asset requirements, and package versions. Manual setup with the wrong SDK version (e.g., SDK 51 when Expo Go runs SDK 54) cascades into version mismatches, missing babel config, and asset errors that require painful debugging to untangle.
```

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
