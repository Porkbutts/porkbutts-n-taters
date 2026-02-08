# Claude Code Hook Guard

## Purpose

AI coding agents sometimes use `--no-verify` to bypass pre-commit hooks when they encounter lint or test failures. This defeats the purpose of having hooks. A `PreToolCall` hook in `.claude/settings.json` hard-blocks this at the tool level, before the command ever runs.

## Configuration

Add to `.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolCall": [
      {
        "matcher": "Bash",
        "command": "if echo \"$TOOL_INPUT\" | grep -qE '\\-\\-no\\-verify|\\-\\-no\\-gpg\\-sign'; then echo 'BLOCKED: --no-verify and --no-gpg-sign are not allowed. Fix the underlying issue instead of bypassing hooks.' >&2; exit 1; fi"
      }
    ]
  }
}
```

## How It Works

- `PreToolCall` hooks run before any tool call is executed
- `"matcher": "Bash"` restricts it to shell commands only
- The hook inspects `$TOOL_INPUT` (the command string) for blocked flags
- If found, it exits non-zero which blocks the tool call entirely
- The error message tells the agent what to do instead

## Merging Into Existing Settings

If `.claude/settings.json` already has content (e.g., `permissions`), merge the `hooks` key into it. If it already has `hooks.PreToolCall`, append to the existing array.

## CLAUDE.md Reinforcement

The hook provides hard enforcement. Adding a rule to `CLAUDE.md` provides soft enforcement so agents don't even attempt the blocked command:

```
NEVER use --no-verify or --no-gpg-sign with git commands. Pre-commit hooks must always run. If a hook fails, fix the underlying issue instead of bypassing it.
```
