---
name: reflect
description: Capture learnings from conversation after Claude made mistakes or needed correction. Trigger phrases include "reflect", "review our mistakes", "review what went wrong", "learn from this", "capture this learning", "remember this for next time", or any request to analyze and persist corrections from the current conversation. Analyzes the conversation to extract what went wrong, how it was resolved, and actionable guidance for future sessions. Writes learnings to project-specific markdown files and maintains an index for easy reference.
---

# Reflect

Analyze the current conversation to extract learnings from mistakes or corrections, then persist them as "if we were starting over" guidance for future sessions.

## Workflow

1. **Identify the problem**: Scan the conversation for where things went wrong - look for user corrections, error messages, failed attempts, or "actually, do X instead" moments

2. **Trace the resolution**: Follow the back-and-forth to understand how the issue was resolved - what did the user clarify? What fix worked?

3. **Synthesize the learning**: Extract the actionable insight - frame it as "if we were starting over, here's the right approach" not "here's how we fixed a mistake"

4. **Ask where to save**: Ask the user whether to save the learning to:
   - **Project** (`docs/learnings/`): For project-specific learnings that should travel with the codebase
   - **Personal** (`~/.claude/learnings/`): For learnings that apply across projects (e.g., general patterns, tool usage, framework gotchas)

   Suggest personal for broadly applicable learnings (like "how to scaffold Expo projects") and project for context-specific ones (like "this codebase uses custom auth middleware"). Also confirm the filename: `YYYY-MM-DD-<topic>.md`

5. **Write the learning**: Use the format below, writing to the chosen location

6. **Update the index**: Add an entry to the appropriate `INDEX.md` (`docs/learnings/INDEX.md` for project, `~/.claude/learnings/INDEX.md` for personal) with an activity-based trigger so Claude consults this learning proactively during planning. Create the index if it doesn't exist (see Index Format below)

## Learning Format

Frame the learning as "if we were starting over, here's the right approach"—lead with what to do, not what went wrong.

```markdown
# <Clear, actionable title - state the right approach>

## Consult when
<Activity-based trigger - what task should prompt reading this?>

## The right approach
<What to do from the start. Be specific: commands, patterns, tools. Write this as if advising someone who hasn't started yet.>

## What to avoid
<The anti-pattern that leads to problems. Name it explicitly so it's recognizable.>

## Why this matters
<Brief explanation of what goes wrong with the anti-pattern. Keep it short—just enough context to understand why the right approach is right.>
```

## Example

File: `~/.claude/learnings/2025-01-10-expo-project-setup.md` (personal) or `docs/learnings/2025-01-10-expo-project-setup.md` (project)

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

## What to avoid
Manually writing package.json and app.json for Expo projects. The interdependencies are too complex to get right by hand.

## Why this matters
Expo has tight coupling between SDK version, babel preset, asset requirements, and package versions. Manual setup with the wrong SDK version (e.g., SDK 51 when Expo Go runs SDK 54) cascades into version mismatches, missing babel config, and asset errors that require painful debugging to untangle.
```

## Index Format

The index maps activities to learning docs so Claude can proactively consult them during planning—before making mistakes.

- **Personal learnings** (`~/.claude/learnings/INDEX.md`): Ensure `~/.claude/CLAUDE.md` references this index so Claude checks it before starting any task
- **Project learnings** (`docs/learnings/INDEX.md`): Reference this in the project's `CLAUDE.md`

### Example ~/.claude/CLAUDE.md

For personal learnings to work, the user's `~/.claude/CLAUDE.md` should include:

```markdown
# Personal Claude Instructions

## Learnings

Before starting any task, consult `~/.claude/learnings/INDEX.md` to check for relevant learnings that apply to the work at hand. These capture lessons from past sessions to avoid repeating mistakes.

Read the full learning file when a "Consult when" trigger matches what you're about to do.
```

```markdown
# Learnings Index

Consult these learnings **during planning** before starting work. Don't wait until something breaks.

## How to use this index
Before starting a task, scan the categories below for relevant learnings. Read them first to avoid known pitfalls.

---

## React Native / Expo
| Consult when | Learning |
|--------------|----------|
| Creating a new Expo project | [2025-01-10-expo-project-setup.md](./2025-01-10-expo-project-setup.md) |

## API / Backend
| Consult when | Learning |
|--------------|----------|
| (no learnings yet) | |

## Testing
| Consult when | Learning |
|--------------|----------|
| (no learnings yet) | |

## Other
| Consult when | Learning |
|--------------|----------|
| (no learnings yet) | |
```

When adding a new learning, find (or create) the appropriate category and add a row with:
- **Consult when**: An activity-based trigger describing when to read this (e.g., "Creating or upgrading an Expo project", "Setting up JWT authentication", "Writing database migrations")
- **Learning**: Relative link to the dated learning file

## Tips for Good Learnings

- **Lead with the right approach**: The learning should read like advice for someone starting fresh, not a debugging post-mortem
- **Be specific**: "Use `npx create-expo-app`" is better than "use the official scaffolding tool"
- **Name the anti-pattern explicitly**: Future Claude needs to recognize when it's about to do the wrong thing. "Manually writing package.json" is specific enough to catch
- **Keep "why this matters" brief**: Just enough context to understand why the right approach is right. The goal isn't to document the debugging journey—it's to prevent it
- **One learning per file**: Keep each learning focused on a single insight
- **Write activity-based triggers**: Frame "Consult when" around what Claude is about to *do*, not what error it might *see*. "Creating an Expo project" matches during planning; "SDK compatibility errors" only matches after failure
