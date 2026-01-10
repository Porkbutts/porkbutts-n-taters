---
name: reflect
description: Capture learnings from conversation after Claude made mistakes or needed correction. Trigger with "/reflect" or "learn from this" after a back-and-forth where the user course-corrected Claude. Analyzes the conversation to extract what went wrong, how it was resolved, and actionable guidance for future sessions. Writes learnings to project-specific markdown files.
---

# Reflect

Analyze the current conversation to extract learnings from mistakes or corrections, then persist them for future sessions.

## Workflow

1. **Identify the problem**: Scan the conversation for where things went wrong - look for user corrections, error messages, failed attempts, or "actually, do X instead" moments

2. **Trace the resolution**: Follow the back-and-forth to understand how the issue was resolved - what did the user clarify? What fix worked?

3. **Synthesize the learning**: Extract the actionable insight - not just "what happened" but "what should future Claude do differently"

4. **Ask where to save**: Confirm the file path with the user (suggest `docs/learnings/<topic>.md` or similar)

5. **Write the learning**: Use the format below

## Learning Format

```markdown
# <Clear, actionable title>

## Context
<What was being attempted - 1-2 sentences>

## Problem
<What went wrong and why - be specific>

## Resolution
<How it was fixed - include code/commands if relevant>

## Guidance
<Actionable advice for future sessions - the key takeaway>
```

## Example

```markdown
# Use Expo SDK 50+ for new React Native projects

## Context
Creating a new React Native app using Expo with the default template.

## Problem
The app failed to load in Expo Go with SDK version compatibility errors. The default template used an older SDK version that wasn't supported by the current Expo Go app.

## Resolution
Updated `app.json` to specify SDK 50, ran `expo upgrade`, and reinstalled dependencies.

## Guidance
When creating new Expo projects, always verify the SDK version in `app.json` is 50 or higher. Run `expo upgrade` if starting from an older template.
```

## Tips for Good Learnings

- **Be specific**: "Use SDK 50+" is better than "use a recent SDK"
- **Include the why**: Explain *why* the problem occurred, not just what happened
- **Make it actionable**: The guidance should be something Claude can act on
- **One learning per file**: Keep each learning focused on a single issue
