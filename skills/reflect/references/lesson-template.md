# Lesson Template

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
